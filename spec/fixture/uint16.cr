require "../../src/binary_parser"

class UInt16Parser < BinaryParser
  uint16 :value
end

UInt16Fixture = IO::Memory.new(sizeof(UInt16))
UInt16Fixture.write_bytes(42u16)
UInt16Fixture.rewind
