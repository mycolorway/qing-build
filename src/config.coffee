_ = require 'lodash'

config =
  name: ''
  githubOwner: ''
  version: ''
  homepage: ''
  umd: {}
  gulp: null

module.exports = config

module.exports.init = (c) ->
  _.extend config, c
