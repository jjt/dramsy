config = require './config'
express = require 'express'
require 'express-resource'
httpProxy = require 'http-proxy'
mongoskin = require 'mongoskin'
_ = require 'lodash'

app = express()

# Proxy to our Yeoman Angular dev server
# TODO: separate into a DEV section of config
proxy = new httpProxy.RoutingProxy()
apiProxy = (host, port) ->
  (req, res, next) ->
    dirs = ['bower_components', 'scripts', 'styles', 'views']
    if req.url.match "^/$|^/#{dirs.join '|^/'}"
      proxy.proxyRequest req, res, {host, port}
    else
      next()

app.configure () ->
  app.use apiProxy 'localhost', 3001
  app.use express.bodyParser()


db = mongoskin.db config.db, safe: true
whiskiesCollection = db.collection 'whiskies'
whiskyFields = (obj) ->
  _.pick obj, [ '_id', 'abv', 'name', 'notes', 'date', 'rating', 'age',
    'flavors']

# Handles new and updating
whiskyUpsert = (req, res) ->
    newObj = req.body
    # Grab the id and strip the key from the update object
    id = req.params?.whisky || newObj._id
    delete newObj._id

    # Would be great to combine these into an upsert that updates only the
    # fields that are passed in, but that proved problematic
    if id
      opts =
        upsert: true
        safe: true
      console.log id, whiskyFields(newObj)
      whiskiesCollection.update { _id: db.ObjectID(id) },
        { $set: whiskyFields(newObj) },
        opts
        (err, doc) ->
          res.json {err, doc}
    else
      whiskiesCollection.insert newObj, {safe: true}, (err, doc) ->
        res.json {err, doc}


    #console.log newObj
    #whiskiesCollection.update { _id: id },
      #{ $set: whiskyFields(newObj) },
      #opts,
      #(err, doc) ->
        #res.json {err, doc}

app.resource 'api/whisky',
  index: (req, res) ->
    whiskies = whiskiesCollection.find().toArray (err, whiskies) ->
      res.json whiskies
  create: whiskyUpsert
  update: whiskyUpsert
  patch: whiskyUpsert
  show: (req, res) ->
    whisky = whiskiesCollection.findById req.params.whisky, (err, doc) ->
      res.json doc
 

app.use (req, res) ->
  res.send 404, 'Whoops, Dramsy had too many.'


app.listen(3000)
console.log 'Bottoms up, cause Dramsy is!'


