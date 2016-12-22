class BinaryParser
  # Declare a string field
  #
  # ### Argument:
  # - name: Field name
  # - opt: Options
  #   - `:count`: Sting length, can be a number for fixed size, `-1` for zero terminated, or a symbol for variable size
  #
  # ### Example:
  # ```crystal
  # # Fixed size
  # class Parser < BinaryParser
  #   string :str, {count: 10} # Array of 10 UInt8
  # end
  #
  # # Variable size
  # class Parser < BinaryParser
  #   uint32 :size
  #   string :str, {count: :size}
  # end
  # ```
  #
  macro string(name, opt = {count: -1})
    property! :{{name.id}}
    @{{name.id}} = ""

    # TODO: Refactor
    def _read_{{name.id}}(io : IO)
      {% if opt[:count].is_a?(NumberLiteral) %}
        {% if opt[:count] != -1 %}
          buf = Slice(UInt8).new({{opt[:count]}})
          io.read(buf)
          str = String.new(buf)
          len = str.byte_index(0) || str.bytesize
          @{{name.id}} = str.byte_slice(0, len)
        {% else %}
          @{{name.id}} = io.gets('\0')
        {% end %}
      {% else %}
        buf = Slice(UInt8).new(@{{opt[:count].id}}.not_nil!)
        io.read(buf)
        str = String.new(buf)
        len = str.byte_index(0) || str.bytesize
        @{{name.id}} = str.byte_slice(0, len)
      {% end %}
    end

    def _write_{{name.id}}(io : IO)
      {% if opt[:count].is_a?(NumberLiteral) %}
        {% if opt[:count] != -1 %}
          slice = Slice(UInt8).new({{opt[:count]}})
          slice.copy_from(@{{name.id}}.not_nil!.to_slice)
          io.write(slice)
        {% else %}
          # FIXME
          io.write(@{{name.id}}.not_nil!.to_slice)
        {% end %}
      {% else %}
        io.write(@{{name.id}}.not_nil!.to_slice)
      {% end %}
    end

    def _size_dyn_{{name.id}}
      {% if opt[:count].is_a?(NumberLiteral) && opt[:count] != -1 %}
        {{opt[:count]}}
      {% else %}
        @{{name.id}}.size
      {% end %}
    end
  end
end
