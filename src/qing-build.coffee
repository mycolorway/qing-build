config = require './config'

module.exports = (c) ->
  config.init c

  compile = require './compile'
  test = require './test'
  publish = require './publish'
  gulp = config.gulp

  dev = gulp.series compile, test, (done) ->
    gulp.watch 'src/**/*.coffee', gulp.series compile.coffee, test
    gulp.watch 'styles/**/*.scss', compile.sass
    gulp.watch 'test/**/*.coffee', test
    done()
  dev.displayName = 'dev'

  gulp.task 'default', dev
  gulp.task 'compile', compile
  gulp.task 'test', test
  gulp.task 'publish', publish

  dev: dev
  compile: compile
  test: test
  publish: publish
