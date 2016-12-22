class BinaryParser
  # Declare a int64 field
  #
  # ```crystal
  # int64 :value # name of field
  # ```
  macro int64(name)
    property! :{{name.id}}
    @{{name.id}} = 0i64

    def _read_{{name.id}}(io : IO)
      @{{name.id}} = io.not_nil!.read_bytes(Int64).as(Int64)
    end

    def _write_{{name.id}}(io : IO)
      io.not_nil!.write_bytes(@{{name.id}}.not_nil!)
    end

    def _size_static_{{name.id}}
      sizeof(Int64)
    end
  end
end
