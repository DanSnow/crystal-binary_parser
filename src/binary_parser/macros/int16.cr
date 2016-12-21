class BinaryParser
  macro int16(name)
    property! :{{name.id}}
    @{{name.id}} = 0i16

    def _read_{{name.id}}(io : IO)
      @{{name.id}} = io.not_nil!.read_bytes(Int16).as(Int16)
    end

    def _write_{{name.id}}(io : IO)
      io.not_nil!.write_bytes(@{{name.id}}.not_nil!)
    end

    def _size_static_{{name.id}}
      sizeof(Int16)
    end
  end
end
