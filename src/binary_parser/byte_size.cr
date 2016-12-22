class BinaryParser
  # Calculate bytesize support
  #
  # ```crystal
  # class Parser < BinaryParser
  #   uint8 :value1
  #   uint8 :value2
  #   include BinaryParser::ByteSize
  # end
  #
  # parser = Parser.new
  # parser.bytesize # sizeof(UInt8) * 2
  # ```
  #
  module ByteSize
    macro included
      @static_size : Int32?

      def bytesize
        dyn_size = 0
        {% for func in @type.methods %}
          {% if func.name.starts_with? "_size_dyn" %}
            dyn_size += {{func.name}}
          {% end %}
        {% end %}
        static_size + dyn_size
      end

      private def static_size
        return @static_size.not_nil! if @static_size
        size = 0
        {% for func in @type.methods %}
          {% if func.name.starts_with? "_size_static" %}
            size += {{func.name}}
          {% end %}
        {% end %}
        @static_size = size
      end
    end
  end
end
