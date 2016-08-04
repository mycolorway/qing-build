gutil = require 'gulp-util'
fs = require 'fs'
request = require 'request'
changelogs = require './helpers/changelogs'
handleError = require './helpers/error'
compile = require './compile'
test = require './test'
_ = require 'lodash'
config = require './config'
gulp = config.gulp

createRelease = (done) ->
  try
    token = _.trim fs.readFileSync('.token').toString()
  catch e
    throw new Error 'Publish: Need github access token for creating release.'
    return

  content = changelogs.latestContent
  unless content
    throw new Error('Publish: Invalid release content in CHANGELOG.md')
    return

  request
    uri: "https://api.github.com/repos/#{config.githubOwner}/#{config.name}/releases"
    method: 'POST'
    json: true
    body:
      tag_name: "v#{config.version}",
      name: "v#{config.version}",
      body: content,
      draft: false,
      prerelease: false
    headers:
      Authorization: "token #{token}",
      'User-Agent': 'Mycolorway Release'
  , (error, response, body) ->
    if error
      handleError error
    else if response.statusCode.toString().search(/2\d\d/) > -1
      message = "#{config.name} v#{config.version} released on github!"
      gutil.log gutil.colors.green message
    else
      message = "#{response.statusCode} #{JSON.stringify response.body}"
      handleError gutil.colors.red message
    done()
createRelease.displayName = 'create-release'

publish = gulp.series [
  compile,
  test,
  createRelease
]..., (done) ->
  done()

module.exports = publish
