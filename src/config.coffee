
config =
  name: ''
  githubOwner: ''
  version: ''
  homepage: ''
  umd: {}

module.exports = ->
  config

module.exports.init = (c) ->
  _.extend config, c
