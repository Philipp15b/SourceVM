{
  var helpers = require('./grammar-helpers'),
      n = require('./nodes');
}

start
  = Program

ws "Whitespace"
   = [\t\v\f \u00A0\uFEFF]

_
  = ws*

__
  = ws+

EndOfLine "End of Line"
  = '\n'
  / "\r\n"
  / "\r"

Identifier "Identfier"
  = name:([a-zA-Z0-9+-] / '_')+
     { return name.join(""); }

StringLiteral "String"
  = '"' content:(!'"' .)* '"'
     { return helpers.every(1, content).join(""); }
  / content:(!(ws / '"' / EndOfLine / ';') .)+
     { return helpers.every(1, content).join(""); }

Program
  = EndOfLine* program:(Statement _ Comment? EndOfLine+)*
   { return new n.Block(helpers.filterProgram(program)).p(line, column); }

Statement "Statement"
  = Comment
  / Command

Comment "Comment"
  = '//' content:(!EndOfLine .)*
     { return new n.Comment(helpers.every(1, content).join("")).p(line, column); }

Command "Command"
  = name:("alias" / "bind") __ arg1:StringLiteral __  arg2:InlineProgram
    { return new n.Command(name, [arg1, arg2]).p(line, column); }
  / name:(!("alias" / "bind") Identifier) args:(__ StringLiteral)*
    { return new n.Command(name[1], args === "" ? null : helpers.every(1, args)).p(line, column); }

InlineProgram
  = '""'
    { return new n.Block([]).p(line, column); }
  / '"' program:((_ Command _ ';')* _ Command)? '"'
    { return new n.Block(helpers.filterInlineProgram(program)).p(line, column); }
  / name:Identifier
    { return new n.Block([new n.Command(name, null).p(line, column)]).p(line, column); }
