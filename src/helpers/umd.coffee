fs = require 'fs'
path = require 'path'
through = require 'through2'
_ = require 'lodash'
config = require '../config'

module.exports = (opts) ->
  umdConfig = _.cloneDeep config.umd
  opts = _.extend umdConfig, opts

  opts.name ||= _.upperFirst(_.camelCase(config.name))

  opts.dependencies.cjs = opts.dependencies.cjs.map (name) ->
    "require('#{name}')"
  .join ','

  opts.dependencies.global = opts.dependencies.global.map (name) ->
    "root.#{name}"
  .join ','

  opts.dependencies.params = opts.dependencies.params.join ','

  tplPath = path.resolve __dirname, '../templates/umd.js'
  tpl = _.template fs.readFileSync(tplPath).toString()

  through.obj (file, encoding, done) ->
    opts.contents = file.contents.toString()
    opts.filename = file.stem
    file.contents = new Buffer tpl opts
    @push file
    done()
