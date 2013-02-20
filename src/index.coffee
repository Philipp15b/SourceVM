nodes = require './nodes'
Runtime = require './runtime'

module.exports =
  nodes: nodes
  Runtime: Runtime

  # Parses the given piece of code and returns the AST.
  #
  # Throws a SyntaxError.
  parse: (code) ->
    code += '\n' if code[code.length-1] isnt '\n'
    parser = require './grammar-parser.js'
    parser.parse code
