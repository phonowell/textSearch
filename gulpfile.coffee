# require

$$ = require 'fire-keeper'
{$, _, Promise} = $$.library
co = Promise.coroutine

# task

###

  build
  lint
  set

###

$$.task 'build', co ->
  yield $$.compile './source/textSearch.coffee', './'

$$.task 'lint', co ->

  yield $$.task('kokoro')()

  yield $$.lint [
    './gulpfile.coffee'
    './source/**/*.coffee'
    './test/**/*.coffee'
  ]

$$.task 'set', co ->

  if !(ver = $$.argv.version) then return

  yield $$.replace './package.json'
  , /"version": "[\d.]+"/, "\"version\": \"#{ver}\""

#$$.task 'z', co ->
