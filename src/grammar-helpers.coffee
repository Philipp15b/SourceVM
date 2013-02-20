module.exports =
  every: (num, array) ->
    nested[num] for nested in array

  filterProgram: (program) ->
    result = []
    for cmd in program
      result.push cmd[0]
      result.push cmd[2] if cmd[2] isnt "" # Comment
    result

  filterInlineProgram: (program) ->
    return [] if program is ""
    statements = (s[1] for s in program[0])
    statements.push program[2]
    statements
