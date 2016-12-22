class BinaryParser
  # Declare a int32 field
  #
  # ```crystal
  # int32 :value # name of field
  # ```
  macro int32(name)
    property! :{{name.id}}
    @{{name.id}} = 0i32

    def _read_{{name.id}}(io : IO)
      @{{name.id}} = io.not_nil!.read_bytes(Int32).as(Int32)
    end

    def _write_{{name.id}}(io : IO)
      io.not_nil!.write_bytes(@{{name.id}}.not_nil!)
    end

    def _size_static_{{name.id}}
      sizeof(Int32)
    end
  end
end
