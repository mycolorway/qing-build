fs = require 'fs'
path = require 'path'
through = require 'through2'
_ = require 'lodash'
config = require '../config'

module.exports = (type = 'full') ->
  now = new Date()
  year = now.getFullYear()
  month = _.padStart(now.getMonth() + 1, 2, '0')
  date = now.getDate()
  tplPath = path.resolve __dirname, "../templates/#{type}-header.txt"
  tpl = fs.readFileSync(tplPath).toString()
  header = _.template(tpl)
    name: config.name
    version: config.version
    homepage: config.homepage
    date: "#{year}-#{month}-#{date}"

  through.obj (file, encoding, done) ->
    headerBuffer = new Buffer header
    file.contents = Buffer.concat [headerBuffer, file.contents]
    @push file
    done()
