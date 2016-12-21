require "../../src/binary_parser"

class Int16Parser < BinaryParser
  int16 :value
end

Int16Fixture = IO::Memory.new(sizeof(Int16))
Int16Fixture.write_bytes(42i16)
Int16Fixture.rewind
