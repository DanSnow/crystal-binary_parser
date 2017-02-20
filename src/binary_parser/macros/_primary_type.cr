class BinaryParser
  # :nodoc:
  macro _primary_type(name, suffix)
    # Internal helper for define primary type like `UInt32`
    #
    # ## Argument:
    # - name: field name
    # - suffix: suffix for declare, like `u32`

    _primary_type({{name}}, {{suffix}}, {{suffix.starts_with?("u") ? "UInt#{suffix[1..-1].id}" : "Int#{suffix[1..-1].id}"}})
  end

  # :nodoc:
  macro _primary_type(name, suffix, type)
    # ## Argument:
    # - name: field name
    # - suffix: suffix for declare, like `u32`
    # - type: like `UInt32`
    property! :{{name.id}}
    @{{name.id}} = 0{{suffix.id}}

    def _read_{{name.id}}(io : IO, format : IO::ByteFormat = IO::ByteFormat::SystemEndian)
      format = endian_config if format == IO::ByteFormat::SystemEndian
      @{{name.id}} = io.not_nil!.read_bytes({{type.id}}, format).as({{type.id}})
    end

    def _write_{{name.id}}(io : IO, format : IO::ByteFormat = IO::ByteFormat::SystemEndian)
      format = format == IO::ByteFormat::SystemEndian ? endian_config : format
      io.not_nil!.write_bytes(@{{name.id}}.not_nil!, format)
    end

    def _size_static_{{name.id}}
      sizeof({{type.id}})
    end
  end
end
