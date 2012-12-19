# The runtime saves important properties about the
# scripts' execution environment. It saves commands,
# binds and aliases.
module.exports = class Runtime
  constructor: ->
    @commands = {} # object of commands with associated callbacks
    @binds = {} # object of binds with associated blocks
    @aliases = {} # object of aliases with associated blocks

  registerCommand: (name, cb) ->
    @commands[name] = cb

  handleCommandNotFound: (node) ->
    console.warn "Could not find command #{node.name} in line #{node.line}, column #{node.column}!"

  run: (root) ->
    runNode = (node) =>
      switch node.type
        when "Block" then runBlock node
        when "Command" then runCommand node
        when "Comment" then undefined
        else throw new Error "Unknown node type #{node.type}!"
      undefined

    runBlock = (block) =>
      for node in block.statements
        runNode node
      undefined

    runCommand = (command) =>
      if command.name is "alias" # set an alias
        @aliases[command.args[0]] = command.args[1]
      else if command.name is "bind" # set a bind
        @binds[command.args[0]] = command.args[1]
      else
        if @aliases[command.name]? # find an alias
          runBlock @aliases[command.name]
        else if @commands[command.name]? # find a command
          @commands[command.name](command.args)
        else
          @handleCommandNotFound command
      undefined

    runBlock root
    undefined
