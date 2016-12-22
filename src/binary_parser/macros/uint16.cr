class BinaryParser
  # Declare a uint16 field
  #
  # ```crystal
  # uint16 :value # name of field
  # ```
  macro uint16(name)
    property! :{{name.id}}
    @{{name.id}} = 0u16

    def _read_{{name.id}}(io : IO)
      @{{name.id}} = io.not_nil!.read_bytes(UInt16).as(UInt16)
    end

    def _write_{{name.id}}(io : IO)
      io.not_nil!.write_bytes(@{{name.id}}.not_nil!)
    end

    def _size_static_{{name.id}}
      sizeof(UInt16)
    end
  end
end
