class BinaryParser
  macro uint32(name)
    property! :{{name.id}}
    @{{name.id}} = 0u32

    def _read_{{name.id}}(io : IO)
      @{{name.id}} = io.not_nil!.read_bytes(UInt32).as(UInt32)
    end

    def _write_{{name.id}}(io : IO)
      io.not_nil!.write_bytes(@{{name.id}}.not_nil!)
    end

    def _size_static_{{name.id}}
      sizeof(UInt32)
    end
  end
end
