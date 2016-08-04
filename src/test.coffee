karma = require 'karma'
fs = require 'fs'
handleError = require './helpers/error'
config = require './config'
gulp = config.gulp

test = (done) ->
  server = new karma.Server
    configFile: "#{process.cwd()}/karma.coffee"
  , (code) ->
    fs.unlinkSync 'test/coverage-init.js'
    if code != 0
      handleError "karma exit with code: #{code}"
    done()

  server.start()

module.exports = test
