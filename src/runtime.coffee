# The runtime saves important properties about the
# scripts' execution environment. It saves commands,
# binds and aliases.
module.exports = class Runtime
  constructor: ->
    @commands = {} # object of commands with associated callbacks
    @binds = {} # object of binds with the associated command
    @aliases = {} # object of aliases with associated blocks

  handleCommandNotFound: (node) ->
    console.warn "Could not find command #{node.name} in line #{node.line}, column #{node.column}!"

  run: (root) ->
    runNode = (node) =>
      switch node.constructor.name
        when "Block"   then runBlock node
        when "Command" then runCommand node
        when "Comment" then # nothing
        else throw new Error "Unknown node type #{node.type}!"
      undefined

    runBlock = (block) =>
      for node in block.statements
        runNode node
      undefined

    runCommand = (cmd) =>
      if      cmd.name is "alias"  then @aliases[cmd.args[0]] = cmd.args[1]
      else if cmd.name is "bind"   then @binds[cmd.args[0]] = cmd.args[1]
      else if @aliases[cmd.name]?  then runBlock @aliases[cmd.name]
      else if @commands[cmd.name]? then @commands[cmd.name](cmd.args)
      else    @handleCommandNotFound cmd
      undefined

    runBlock root
    undefined
