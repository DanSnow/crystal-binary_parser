class BinaryParser
  # Declare an array field
  #
  # ### Argument:
  # - name: Field name
  # - opt: Options
  #   - `:type`: Element type, must respond to `from_io`
  #   - `:count`: Element size, can be a number for fixed size, or a symbol for variable size
  #
  # ### Example:
  # ```
  # # Fixed size
  # class Parser < BinaryParser
  #   array :arr, {type: UInt8, count: 10} # Array of 10 UInt8
  # end
  #
  # # Variable size
  # class Parser < BinaryParser
  #   uint32 :size
  #   array :arr, {type: UInt8, count: :size}
  # end
  # ```
  #
  macro array(name, opt)
    {% raise "Must have count and type" unless opt[:type] && opt[:count] %}
    property! :{{name.id}}
    @{{name.id}} = [] of {{opt[:type]}}

    def _read_{{name.id}}(io : IO, format : IO::ByteFormat = IO::ByteFormat::SystemEndian)
      {% if opt[:count].is_a?(NumberLiteral) %}
        @{{name.id}} = Array({{opt[:type]}}).new({{opt[:count]}}) do
          io.read_bytes({{opt[:type]}}, format)
        end
      {% elsif opt[:count].id != "eof" %}
        @{{name.id}} = Array({{opt[:type]}}).new(@{{opt[:count].id}}.not_nil!) do
          io.read_bytes({{opt[:type]}}, format)
        end
      {% else %}
        @{{name.id}} = [] of {{opt[:type]}}
        # TODO: support :eof
      {% end %}
    end

    def _write_{{name.id}}(io : IO, format : IO::ByteFormat = IO::ByteFormat::SystemEndian)
      @{{name.id}}.not_nil!.each do |item|
        io.write_bytes(item, format)
      end
    end

    def _size_dyn_{{name.id}}
      {% if opt[:type].resolve < BinaryParser %}
        res = @{{name.id}}.reduce(0) do |size, x|
          size + x.bytesize
        end
        res
      {% else %}
        @{{name.id}}.size * sizeof({{opt[:type]}})
      {% end %}
    end
  end
end
