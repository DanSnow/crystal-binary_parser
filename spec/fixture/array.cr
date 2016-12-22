require "../../src/binary_parser"

class FixedArrayParser < BinaryParser
  array :arr, {type: UInt8, count: 5}
end

FixedArrayFixture = IO::Memory.new(sizeof(UInt8) * 5)
5.times do |i|
  FixedArrayFixture.write_bytes(42u8 + i)
end
FixedArrayFixture.rewind

class VarArrayParser < BinaryParser
  uint32 :size
  array :arr, {type: UInt8, count: :size}
end

VarArrayFixture = IO::Memory.new(sizeof(UInt32) + sizeof(UInt8) * 5)
VarArrayFixture.write_bytes(5u32)
5.times do |i|
  VarArrayFixture.write_bytes(42u8 + i)
end
VarArrayFixture.rewind
