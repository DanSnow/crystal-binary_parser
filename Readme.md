crystal-binary_parser
=====================

## Description ##

**Will publish first version after document done**  
A binary parser for crystal.

## Install ##

Add this to your `shard.yml`  
```yml
dependencies:
  binary_parser:
    github: DanSnow/crystal-binary_parser
```

## Feature ##

- Parse and write binary file
- Support array (fixed size or variable size)
- Support string (fixed length or valirable length)
- Support nested parser
- Calculate byte size

## Usage ##

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

## License ##
MIT
