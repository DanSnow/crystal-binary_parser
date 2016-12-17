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

  macro uint32(name)
    property! :{{name.id}}
    @{{name.id}} = 0u32

    def _read_{{name.id}}(io : IO)
      @{{name.id}} = io.not_nil!.read_bytes(UInt32).as(UInt32)
    end

    def _write_{{name.id}}(io : IO)
      io.not_nil!.write_bytes(@{{name.id}}.not_nil!)
    end
  end

  macro uint16(name)
    property! :{{name.id}}
    @{{name.id}} = 0u16

    def _read_{{name.id}}(io : IO)
      @{{name.id}} = io.not_nil!.read_bytes(UInt16).as(UInt16)
    end

    def _write_{{name.id}}(io : IO)
      io.not_nil!.write_bytes(@{{name.id}}.not_nil!)
    end
  end

  macro uint8(name)
    property! :{{name.id}}
    @{{name.id}} = 0u8

    def _read_{{name.id}}(io : IO)
      @{{name.id}} = io.not_nil!.read_bytes(UInt8).as(UInt8)
    end

    def _write_{{name.id}}(io : IO)
      io.not_nil!.write_bytes(@{{name.id}}.not_nil!)
    end
  end

  macro int32(name)
    property! :{{name.id}}
    @{{name.id}} = 0i32

    def _read_{{name.id}}(io : IO)
      @{{name.id}} = io.not_nil!.read_bytes(Int32).as(Int32)
    end

    def _write_{{name.id}}(io : IO)
      io.not_nil!.write_bytes(@{{name.id}}.not_nil!)
    end
  end

  macro int16(name)
    property! :{{name.id}}
    @{{name.id}} = 0i16

    def _read_{{name.id}}(io : IO)
      @{{name.id}} = io.not_nil!.read_bytes(Int16).as(Int16)
    end

    def _write_{{name.id}}(io : IO)
      io.not_nil!.write_bytes(@{{name.id}}.not_nil!)
    end
  end

  macro int8(name)
    property! :{{name.id}}
    @{{name.id}} = 0i8

    def _read_{{name.id}}(io : IO)
      @{{name.id}} = io.not_nil!.read_bytes(Int8).as(Int8)
    end

    def _write_{{name.id}}(io : IO)
      io.not_nil!.write_bytes(@{{name.id}}.not_nil!)
    end
  end

  macro char(name)
    property! :{{name.id}}
    @{{name.id}} = '\0'

    def _read_{{name.id}}(io : IO)
      @{{name.id}} = io.not_nil!.read_char
    end
  end

  macro type(name, klass)
    property! :{{name.id}}
    @{{name.id}} = {{klass}}.new

    def _read_{{name.id}}(io : IO)
      {% raise "Must inhert BinaryParser" if  @type >= klass.resolve %}
      @{{name.id}} = io.read_bytes({{klass}}).as({{klass}})
    end

    def _write_{{name.id}}(io : IO)
      io.write_bytes(@{{name.id}}.not_nil!)
    end
  end

  macro array(name, opt)
    {% raise "Must have count and type" unless opt[:type] && opt[:count]  %}
    property! :{{name.id}}
    @{{name.id}} = [] of {{opt[:type]}}

    def _read_{{name.id}}(io : IO)
      {% if opt[:count].is_a?(NumberLiteral) %}
        @{{name.id}} = Array({{opt[:type]}}).new({{opt[:count]}}) do
          io.read_bytes({{opt[:type]}})
        end
      {% elsif opt[:count].id != "eof" %}
        @{{name.id}} = Array({{opt[:type]}}).new(@{{opt[:count].id}}.not_nil!) do
          io.read_bytes({{opt[:type]}})
        end
      {% else %}
        @{{name.id}} = [] of {{opt[:type]}}
        # TODO: support :eof
      {% end %}
    end

    def _write_{{name.id}}(io : IO)
      @{{name.id}}.not_nil!.each do |item|
        io.write_bytes(item)
      end
    end
  end

  macro string(name, opt = { count: -1 })
    property! :{{name.id}}
    @{{name.id}} = ""

    def _read_{{name.id}}(io : IO)
      {% if opt[:count] != -1 %}
        buf = Slice(UInt8).new({{opt[:count]}})
        io.read(buf)
        str = String.new(buf)
        len = str.byte_index(0) || str.bytesize
        @{{name.id}} = str.byte_slice(0, len)
      {% else %}
        @{{name.id}} = io.gets('\0')
      {% end %}
    end

    def _write_{{name.id}}(io : IO)
      {% if opt[:count] != -1 %}
        slice = Slice(UInt8).new({{opt[:count]}})
        slice.copy_from(@{{name.id}}.not_nil!.to_slice)
        io.write(slice)
      {% else %}
        io.write(@{{name.id}}.not_nil!.to_slice)
      {% end %}
    end
  end
end
