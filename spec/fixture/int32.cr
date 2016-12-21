require "../../src/binary_parser"

class Int32Parser < BinaryParser
  int8 :value
end

Int32Fixture = IO::Memory.new(sizeof(Int32))
Int32Fixture.write_bytes(42i32)
Int32Fixture.rewind
