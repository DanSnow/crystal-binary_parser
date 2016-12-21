require "./spec_helper"
require "./fixture/*"

describe BinaryParser do
  describe "uint32" do
    it "parse correct" do
      parser = UInt32Parser.new.load(UINT32_FIXTURE)
      expect(parser.value).to eq(42)
    end
  end

  describe "uint8" do
    it "parse correct" do
      parser = UInt8Parser.new.load(UINT8_FIXTURE)
      expect(parser.value).to eq(42)
    end
  end
end

