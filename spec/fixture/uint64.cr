require "../../src/binary_parser"

class UInt64Parser < BinaryParser
  uint64 :value
end

UInt64Fixture = IO::Memory.new(sizeof(UInt64))
UInt64Fixture.write_bytes(42u64)
UInt64Fixture.rewind
