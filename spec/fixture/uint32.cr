require "../../src/binary_parser"

class UInt32Parser < BinaryParser
  uint32 :value
end

UInt32Fixture = IO::Memory.new(sizeof(UInt32))
UInt32Fixture.write_bytes(42u32)
UInt32Fixture.rewind
