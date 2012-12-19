createNodes = (superclass, data) ->
  nodes = {}
  for name, properties of data then do (name, properties) ->
    klass = class extends superclass
      constructor: unless properties? then ->
        @type = name
      else ->
        for property, i in properties
          @[property] = arguments[i]
        @type = name

    nodes[name] = klass

  nodes

# Base class
class Node
  p: (@line, @column) ->
    this

module.exports = createNodes Node,
  Block: ['statements']
  Command: ['name', 'args']
  Comment: ['content']
