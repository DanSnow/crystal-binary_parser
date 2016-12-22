class BinaryParser
  # Declare a uint8 field
  #
  # ```crystal
  # uint8 :value # name of field
  # ```
  macro uint8(name)
    property! :{{name.id}}
    @{{name.id}} = 0u8

    def _read_{{name.id}}(io : IO)
      @{{name.id}} = io.not_nil!.read_bytes(UInt8).as(UInt8)
    end

    def _write_{{name.id}}(io : IO)
      io.not_nil!.write_bytes(@{{name.id}}.not_nil!)
    end

    def _size_static_{{name.id}}
      sizeof(UInt8)
    end
  end
end
