class BinaryParser

  # Nested BinaryParser
  #
  # ### Argument:
  # - name: Field name
  # - klass: Another BinaryParser
  #
  # ### Example:
  # ```crystal
  #
  # class InnerParser < BinaryParser
  #   uint8 :foo
  # end
  #
  # class Parser < BinaryParser
  #   type :inner, InnerParser
  # end
  # ```
  #
  macro type(name, klass)
    property! :{{name.id}}
    @{{name.id}} = {{klass}}.new

    def _read_{{name.id}}(io : IO)
      {% raise "Must inhert BinaryParser" if  BinaryParser < klass.resolve %}
      @{{name.id}} = io.read_bytes({{klass}}).as({{klass}})
    end

    def _write_{{name.id}}(io : IO)
      io.write_bytes(@{{name.id}}.not_nil!)
    end

    def _size_dyn_{{name.id}}
      @{{name.id}}.bytesize
    end
  end
end
