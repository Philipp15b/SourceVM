Runtime = require './runtime'

module.exports =
  Runtime: Runtime

  # Parses the given piece of code and returns the AST.
  #
  # Throws a SyntaxError
  parse: (code) ->
    parser = require './grammar-parser.js'
    parser.parse code
