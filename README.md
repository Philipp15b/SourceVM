# SourceVM

This is a simple interpreter library for the [Source Config](https://developer.valvesoftware.com/wiki/CFG).
Support for commands, aliases and binds is included.

## Example

```coffeescript
sourcevm = require 'source-vm'
code = """
alias "hello" "echo "hello world""
hello
"""

r = new sourcevm.Runtime()
r.commands["echo"] = (cmd) -> console.log cmd.args[0]

ast = sourcevm.parse code
r.run ast
```

## Syntax

The syntax is a simplified version of the Source Config. It only contains calling commands and
nesting programs in aliases. For more information, see `src/grammar.pegjs`.

All code produced by [SourceScript](http://sourcescript.philworld.de/) should be valid code too.

## License

SourceVM is licensed under the MIT license.
