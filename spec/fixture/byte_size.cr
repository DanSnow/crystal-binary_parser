require "../../src/binary_parser"

class ByteSizeFixture < BinaryParser
  uint8 :foo
  uint32 :bar
  uint32 :size
  string :str, { count: :size }
  array :arr, { count: :size, type: UInt8 }
  include BinaryParser::ByteSize
end

