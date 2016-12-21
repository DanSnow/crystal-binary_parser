require "./spec_helper"
require "./fixture/*"

describe BinaryParser::ByteSize do
  describe "#bytesize" do
    it "calculate size in byte" do
      size = sizeof(UInt32) * 2 + sizeof(UInt8)
      parser = ByteSizeFixture.new

      expect(parser.bytesize).to eq(size)
      parser.str = "foo"
      expect(parser.bytesize).to eq(size + 3)
      parser.arr = [0u8, 1u8, 2u8]
      expect(parser.bytesize).to eq(size + 3 + sizeof(UInt8) * 3)
    end
  end
end
