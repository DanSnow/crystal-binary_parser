class BinaryParser
  macro char(name)
    property! :{{name.id}}
    @{{name.id}} = '\0'

    def _read_{{name.id}}(io : IO)
      @{{name.id}} = io.not_nil!.read_char
    end

    def _size_static_{{name.id}}
      sizeof(Char)
    end
  end
end
