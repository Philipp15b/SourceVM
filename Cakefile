{exec} = require 'child_process'
{readFileSync, existsSync, writeFileSync, unlinkSync} = require 'fs'
wrench = require 'wrench'
PEG = require 'pegjs'

task 'clean', 'clean up the build path', ->
  wrench.rmdirSyncRecursive 'lib' if existsSync 'lib'

task 'build', 'build SourceScript from source', ->
  invoke 'clean'

  exec 'coffee --compile --output lib/ src/', (err, stdout, stderr) ->
    throw err if err
    console.log stdout + stderr
    invoke 'build:parser'

task 'build:parser', 'build the peg.js parser', ->
  grammar = readFileSync('src/grammar.pegjs').toString()
  parser = PEG.buildParser grammar,
    trackLineAndColumn: on

  writeFileSync "./lib/grammar-parser.js", "module.exports = #{parser.toSource()}"
