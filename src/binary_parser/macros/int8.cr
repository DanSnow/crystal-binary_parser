class BinaryParser
  # Declare a int8 field
  #
  # ```crystal
  # int8 :value # name of field
  # ```
  macro int8(name)
    property! :{{name.id}}
    @{{name.id}} = 0i8

    def _read_{{name.id}}(io : IO)
      @{{name.id}} = io.not_nil!.read_bytes(Int8).as(Int8)
    end

    def _write_{{name.id}}(io : IO)
      io.not_nil!.write_bytes(@{{name.id}}.not_nil!)
    end

    def _size_static_{{name.id}}
      sizeof(Int8)
    end
  end
end
