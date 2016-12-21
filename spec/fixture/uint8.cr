require "../../src/binary_parser"

class UInt8Parser < BinaryParser
  uint8 :value
end

UINT8_FIXTURE = IO::Memory.new(sizeof(UInt8))
UINT8_FIXTURE.write_bytes(42u8)
UINT8_FIXTURE.rewind
