class BinaryParser
  # Declare a uint64 field
  #
  # ```crystal
  # uint64 :value # name of field
  # ```
  macro uint64(name)
    property! :{{name.id}}
    @{{name.id}} = 0u64

    def _read_{{name.id}}(io : IO)
      @{{name.id}} = io.not_nil!.read_bytes(UInt64).as(UInt64)
    end

    def _write_{{name.id}}(io : IO)
      io.not_nil!.write_bytes(@{{name.id}}.not_nil!)
    end

    def _size_static_{{name.id}}
      sizeof(UInt64)
    end
  end
end
