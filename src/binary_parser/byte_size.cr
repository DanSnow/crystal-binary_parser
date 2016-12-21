class BinaryParser
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
