_ = require 'lodash'
configLocal = require './configLOCAL'
config = _.assign {}, configLocal
config.db = "mongodb://#{config.dbuser}:#{config.dbpass}@#{config.dbhost}/#{config.dbname}"

module.exports = config
    
