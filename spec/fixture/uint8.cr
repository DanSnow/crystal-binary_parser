require "../../src/binary_parser"

class UInt8Parser < BinaryParser
  uint8 :value
end

UInt8Fixture = IO::Memory.new(sizeof(UInt8))
UInt8Fixture.write_bytes(42u8)
UInt8Fixture.rewind
