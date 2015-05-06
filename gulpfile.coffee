#============
#require
#============
#exec
exec = (require 'child_process').exec

#gulp
gulp = require 'gulp'

#tool
gutil = require 'gulp-util'
watch = require 'gulp-watch'
plumber = require 'gulp-plumber'
replace = require 'gulp-replace'
clean = require 'gulp-clean'
ignore = require 'gulp-ignore'
concat = require 'gulp-concat'
rename = require 'gulp-rename'
cb = require 'gulp-callback'

#type
jade = require 'gulp-jade'
coffee = require 'gulp-coffee'
stylus = require 'gulp-stylus'
cson = require 'gulp-cson'

#advanced tool
uglify = require 'gulp-uglify'

#lint
lint = require 'gulp-coffeelint'

#============
#error
#============
#uncaughtException
process.on 'uncaughtException', (err) -> log err.stack

#============
#function
#============
#log
log = console.log

#path
parsePath = (param) ->
  _path = '!./node_modules/**'
  switch typeof param
    when 'string'
      [param, _path]
    else
      param.push _path
      param

#============
#param
#============
#base
base = process.cwd()

#path
path =
  source: './source/'
  build: './build/'
path.jade = parsePath path.source + '**/*.jade'
path.stylus = parsePath path.source + '**/*.styl'
path.coffee = parsePath path.source + '**/*.coffee'
path.cson = parsePath path.source + '**/*.cson'

#============
#task
#============

#watch
gulp.task 'watch', ->

  #coffee
  watch path.coffee
  .pipe plumber()
  #lint
  .pipe lint()
  .pipe lint.reporter()
  #coffee
  .pipe coffee()
  .pipe gulp.dest './build/'
  #uglify
  .pipe uglify()
  .pipe rename suffix: '.min'
  .pipe gulp.dest './build'

#lint
gulp.task 'lint', ->
  gulp.src path.coffee
  .pipe lint()
  .pipe lint.reporter()

#build
gulp.task 'build', ->

  #clean
  gulp.src path.build
  .pipe clean()
  .pipe cb ->

    #coffee
    gulp.src path.coffee
    .pipe plumber()
    #lint
    .pipe lint()
    .pipe lint.reporter()
    #coffee
    .pipe coffee()
    .pipe gulp.dest './build/'
    #uglify
    .pipe uglify()
    .pipe rename suffix: '.min'
    .pipe gulp.dest './build'

#clean
gulp.task 'clean', ->
  gulp.src parsePath path.source + '**/*.min.min.js'
  .pipe clean()