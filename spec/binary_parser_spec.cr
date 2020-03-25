require "./spec_helper"
require "./fixture/*"

describe BinaryParser do
  describe "#load" do
    it "load binary" do
      parser = UInt32Parser.new.load(UInt32Fixture)
      UInt32Fixture.rewind

      parser.value.should eq 42
    end

    it "respect to IO::ByteFormat" do
      parser = UInt32Parser.new.load(BigEndianUInt32Fixture, IO::ByteFormat::BigEndian)
      BigEndianUInt32Fixture.rewind

      parser.value.should eq 42
    end
  end

  describe "#endian" do
    it "work correct" do
      parser = BigEndianParser.new.load(BigEndianUInt32Fixture)
      BigEndianUInt32Fixture.rewind

      parser.value.should eq 42
    end
  end

  describe "#uint64" do
    it "parse correct" do
      parser = UInt64Parser.new.load(UInt64Fixture)

      parser.value.should eq 42
    end
  end

  describe "#uint32" do
    it "parse correct" do
      parser = UInt32Parser.new.load(UInt32Fixture)
      UInt32Fixture.rewind

      parser.value.should eq 42
    end
  end

  describe "#uint16" do
    it "parse correct" do
      parser = UInt16Parser.new.load(UInt16Fixture)

      parser.value.should eq 42
    end
  end

  describe "#uint8" do
    it "parse correct" do
      parser = UInt8Parser.new.load(UInt8Fixture)

      parser.value.should eq 42
    end
  end

  describe "#int64" do
    it "parse correct" do
      parser = Int64Parser.new.load(Int64Fixture)

      parser.value.should eq 42
    end
  end

  describe "#int32" do
    it "parse correct" do
      parser = Int32Parser.new.load(Int32Fixture)

      parser.value.should eq 42
    end
  end

  describe "#int16" do
    it "parse correct" do
      parser = Int16Parser.new.load(Int16Fixture)

      parser.value.should eq 42
    end
  end

  describe "#int8" do
    it "parse correct" do
      parser = Int8Parser.new.load(Int8Fixture)

      parser.value.should eq 42
    end
  end

  describe "#array" do
    context "when fixed length" do
      it "parse correct" do
        parser = FixedArrayParser.new.load(FixedArrayFixture)

        parser.arr.should eq [42, 43, 44, 45, 46]
      end
    end

    context "when variable length" do
      it "parse correct" do
        parser = VarArrayParser.new.load(VarArrayFixture)

        parser.size.should eq 5
        parser.arr.should eq [42, 43, 44, 45, 46]
      end
    end
  end
end
