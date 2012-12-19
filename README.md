# SourceVM

This is a very simple and incomplete interpreter library for the [Source Config](https://developer.valvesoftware.com/wiki/CFG). It is intended to be used for testing [SourceScript](http://sourcescript.philworld.de/).

## Usage

```coffeescript
sourcevm = require 'source-vm'
ast = sourcevm.parse code
r = new sourcevm.Runtime()
r.run ast
```

## Syntax

The syntax is a simplified version of the Source Config. To see what is allowed, see `src/grammar.pegjs`.

All code produced by SourceScript should be valid code too.
