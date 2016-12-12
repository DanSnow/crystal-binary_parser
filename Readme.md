crystal-binary_parser
=====================

## Description ##

** Still under devlopment **  
A binary parser for crystal.

## Install ##

Add this to your `shard.yml`  
```yml
dependencies:
  binary_parser:
    github: DanSnow/crystal-binary_parser
```

## Usage ##

```crystal
require "binary_parser"

class Parser < BinaryParser
  unit8 :foo
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

## API ##
** TODO **

## License ##
MIT
