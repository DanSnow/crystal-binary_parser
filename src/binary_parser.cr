require "./binary_parser/macros/*"

class BinaryParser
  def load(filename : String)
    io = File.open(filename)
    load(io)
  end

  def load(io : IO)
    {% for method in @type.methods %}
      {% if method.name.starts_with?("_read_") %}
        {{method.name}}(io)
      {% end %}
    {% end %}
    self
  end

  def save(filename : String)
    io = File.open(filename, "w")
    write(io)
  end

  def to_s(io : IO)
    write(io)
  end

  def write(io : IO)
    {% for method in @type.methods %}
      {% if method.name.starts_with?("_write_") %}
        {{method.name}}(io)
      {% end %}
    {% end %}
    self
  end

  def self.from_io(io : IO, format : IO::ByteFormat)
    ins = self.new
    ins.load(io)
  end

  def to_io(io : IO, format : IO::ByteFormat)
    write(io)
  end
end

require "./binary_parser/byte_size"

