INDENT = "    "

class Node
  p: (@line, @column) -> this

module.exports =
  Block: class Block extends Node
    constructor: (@statements) ->
    toString: (idt = '') ->
      tree = idt + "Block\n"
      idt += INDENT
      for statement in @statements
        tree += statement.toString(idt) + "\n"
      tree

  Command: class Command extends Node
    constructor: (@name, @args) ->
    toString: (idt = '') ->
      tree = idt + "Command \"#{@name}\""
      idt += INDENT
      for arg in @args
        v = if arg.substr? then "#{idt}'#{arg}'" else arg.toString idt
        tree += "\n" + v
      tree

  Comment: class Comment extends Node
    constructor: (@content) ->
    toString: (idt = '') -> idt + "Comment \"#{@content}\""
