require "../../src/binary_parser"

class Int64Parser < BinaryParser
  int64 :value
end

Int64Fixture = IO::Memory.new(sizeof(Int64))
Int64Fixture.write_bytes(42i64)
Int64Fixture.rewind
