{
  var helpers = require('./grammar-helpers');
  var n = require('./nodes');
}

start
  = program

ws "Whitespace"
   = [\t\v\f \u00A0\uFEFF]
_
  = ws*

__
  = ws+

Identifier "Identfier"
  = name:([a-zA-Z0-9+-] / '_')+
     { return name.join(""); }

EndOfLine "End of Line"
  = '\n'
  / "\r\n"
  / "\r"

program
  = StatementSeperator* program:(Statement Comment? StatementSeperator+)*
   { return new n.Block(helpers.filterProgram(program)).p(line, column); }

StatementSeperator
  = _ (EndOfLine / ';') _

StringLiteral
  = '"' content:(!'"' .)* '"'
     { return helpers.every(1, content).join(""); }
  / Identifier

Statement
  = Command
  / Comment

Command "Command"
  = BlockCommand
  / name:(!BlockCommandName Identifier) args:(__ StringLiteral)*
    { return new n.Command(name[1], args == "" ? null : helpers.every(1, args)).p(line, column); }

BlockCommandName
  = "alias" / "bind"

BlockCommand "Block Command"
  = name:BlockCommandName __ arg1:StringLiteral __ arg2:('"' program '"')
    { return new n.Command(name, [arg1, arg2[1]]).p(line, column); }

Comment "Comment"
  = '#' content:(!EndOfLine .)*
     { return new n.Comment(helpers.every(1, content).join("")).p(line, column); }
