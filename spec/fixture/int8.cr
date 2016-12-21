require "../../src/binary_parser"

class Int8Parser < BinaryParser
  int8 :value
end

Int8Fixture = IO::Memory.new(sizeof(Int8))
Int8Fixture.write_bytes(42i8)
Int8Fixture.rewind
