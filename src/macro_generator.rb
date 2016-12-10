%w(UInt32 UInt16 UInt8 Int32 Int16 Int8).each do |type|
  puts <<~EOD
    macro #{type.downcase}(name)
      property! :{{name.id}}

      def _read_{{name.id}}(io : IO)
        @{{name.id}} = io.not_nil!.read_bytes(#{type}).as(#{type})
      end
    end

  EOD
end
