crystal-binary_parser
=====================

[![CircleCI](https://circleci.com/gh/DanSnow/crystal-binary_parser.svg?style=shield)](https://circleci.com/gh/DanSnow/crystal-binary_parser)
[![GitHub release](https://img.shields.io/github/release/DanSnow/crystal-binary_parser.svg?style=flat-square)](https://github.com/DanSnow/crystal-binary_parser/releases)

Description
-----------

A binary parser for crystal.

Requirement
-----------

- crystal >= 0.20.0

Install
-------

Add this to your `shard.yml`  
```yml
dependencies:
  binary_parser:
    github: DanSnow/crystal-binary_parser
```

Feature
-------

- Parse and write binary file
- Support array (fixed size or variable size)
- Support string (fixed length or valirable length)
- Support nested parser
- Support config which endian to use
- Calculate byte size

Usage
-----

```crystal
require "binary_parser"

class Parser < BinaryParser
  uint8 :foo
end

# Load a file
parser = Parser.new
parser.load("<filename>")

# Or from IO
io = File.open("<filename>")
parser = Parser.new
parser.load(io)

# Now you can get your data
puts parser.foo
```

License
-------

MIT
