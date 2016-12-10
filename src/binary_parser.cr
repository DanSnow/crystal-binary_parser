class BinaryParser
  @io : IO?

  def load(filename : String)
    @io = File.open(filename)
    load(@io.not_nil!)
  end

  def load(io : IO)
    {% for method in @type.methods %}
      {% if method.name.starts_with?("_read_") %}
        {{method.name}}(io)
      {% end %}
    {% end %}
    self
  end

  def self.from_io(io : IO, format : IO::ByteFormat)
    ins = self.new
    ins.load(io)
  end

  macro uint32(name)
    property! :{{name.id}}

    def _read_{{name.id}}(io : IO)
      @{{name.id}} = io.not_nil!.read_bytes(UInt32).as(UInt32)
    end
  end

  macro uint16(name)
    property! :{{name.id}}

    def _read_{{name.id}}(io : IO)
      @{{name.id}} = io.not_nil!.read_bytes(UInt16).as(UInt16)
    end
  end

  macro uint8(name)
    property! :{{name.id}}

    def _read_{{name.id}}(io : IO)
      @{{name.id}} = io.not_nil!.read_bytes(UInt8).as(UInt8)
    end
  end

  macro int32(name)
    property! :{{name.id}}

    def _read_{{name.id}}(io : IO)
      @{{name.id}} = io.not_nil!.read_bytes(Int32).as(Int32)
    end
  end

  macro int16(name)
    property! :{{name.id}}

    def _read_{{name.id}}(io : IO)
      @{{name.id}} = io.not_nil!.read_bytes(Int16).as(Int16)
    end
  end

  macro int8(name)
    property! :{{name.id}}

    def _read_{{name.id}}(io : IO)
      @{{name.id}} = io.not_nil!.read_bytes(Int8).as(Int8)
    end
  end

  macro char(name)
    property! :{{name.id}}

    def _read_{{name.id}}(io : IO)
      @{{name.id}} = io.not_nil!.read_char
    end
  end

  macro type(name, klass)
    property! :{{name.id}}

    def _read_{{name.id}}(io : IO)
      {% raise "Must inhert BinaryParser" if  @type >= klass.resolve %}
      @{{name.id}} = io.read_bytes({{klass}}).as({{klass}})
    end
  end

  macro array(name, opt)
    property! :{{name.id}}

    def _read_{{name.id}}(io : IO)
      {% raise "Must have count or type" unless opt[:type] && opt[:count]  %}
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
  end
end
