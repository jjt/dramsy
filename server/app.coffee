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
app.resource 'api/whisky',
  index: (req, res) ->
    whiskies = whiskiesCollection.find().toArray (err, whiskies) ->
      res.json whiskies
  create: (req, res) ->
    whiskiesCollection.save req.body, (err, doc) ->
      res.json {err, doc}
  show: (req, res) ->
    console.log req.params
    whisky = whiskiesCollection.findById req.params.whisky, (err, doc) ->
      res.json {err, doc}
  update: (req, res) ->
    updateObj =
      $set: _.omit req.body, '_id'
    whiskiesCollection.updateById req.params.whisky, updateObj, (err, doc) ->
      res.json {err, doc}
 

app.use (req, res) ->
  res.send 404, 'Whoops, Dramsy had too many.'


app.listen(3000)
console.log 'Bottoms up, cause Dramsy is!'


