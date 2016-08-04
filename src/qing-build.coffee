gulp = require 'gulp'
compile = require './compile.coffee'
test = require './test.coffee'
publish = require './publish.coffee'

build = gulp.series lint, compile, test, (done) ->
  gulp.watch 'src/**/*.coffee', gulp.series compile.coffee, test
  gulp.watch 'styles/**/*.scss', compile.sass
  gulp.watch 'test/**/*.coffee', test
  done()

module.exports = (c) ->
  config.init c

_.extend module.exports,
  build: build
  compile: compile
  test: test
  publish: publish
