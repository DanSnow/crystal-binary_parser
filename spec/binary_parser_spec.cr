require "./spec_helper"
require "./fixture/*"

describe BinaryParser do
  describe "#uint32" do
    it "parse correct" do
      parser = UInt32Parser.new.load(UInt32Fixture)
      expect(parser.value).to eq(42)
    end
  end

  describe "#uint16" do
    it "parse correct" do
      parser = UInt16Parser.new.load(UInt16Fixture)
      expect(parser.value).to eq(42)
    end
  end

  describe "#uint8" do
    it "parse correct" do
      parser = UInt8Parser.new.load(UInt8Fixture)
      expect(parser.value).to eq(42)
    end
  end

  describe "#int32" do
    it "parse correct" do
      parser = Int32Parser.new.load(Int32Fixture)
      expect(parser.value).to eq(42)
    end
  end

  describe "#int16" do
    it "parse correct" do
      parser = Int16Parser.new.load(Int16Fixture)
      expect(parser.value).to eq(42)
    end
  end

  describe "#int8" do
    it "parse correct" do
      parser = Int8Parser.new.load(Int8Fixture)
      expect(parser.value).to eq(42)
    end
  end

  describe "#array" do
    context "when fixed length" do
      it "parse correct" do
        parser = FixedArrayParser.new.load(FixedArrayFixture)
        expect(parser.arr).to eq([42, 43, 44, 45, 46])
      end
    end

    context "when variable length" do
      it "parse correct" do
        parser = VarArrayParser.new.load(VarArrayFixture)
        expect(parser.size).to eq(5)
        expect(parser.arr).to eq([42, 43, 44, 45, 46])
      end
    end
  end
end

