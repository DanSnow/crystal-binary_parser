require "../../src/binary_parser"

class UInt32Parser < BinaryParser
  uint32 :value
end

UINT32_FIXTURE = IO::Memory.new(sizeof(UInt32))
UINT32_FIXTURE.write_bytes(42u32)
UINT32_FIXTURE.rewind
