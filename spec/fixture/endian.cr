require "../../src/binary_parser"

class BigEndianParser < BinaryParser
  endian :big
  uint32 :value
end


BigEndianUInt32Fixture = IO::Memory.new(sizeof(UInt32))
BigEndianUInt32Fixture.write_bytes(42u32, IO::ByteFormat::BigEndian)
BigEndianUInt32Fixture.rewind
