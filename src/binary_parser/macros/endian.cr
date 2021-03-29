class BinaryParser
  @@endian : Symbol = :system

  # Define what endian to use. `endian` can be either `:little` or  `:big`
  #
  # This macro should be place at the top of class, and can only call **zero** or **one** time.
  #
  # ```
  # endian
  # ```
  macro endian(type)
    {% raise "Endian should be either :big or :little" if type != :big && type != :little %}
    @@endian = {{type}}
  end

  private def endian_config
    case @@endian
    when :little
      IO::ByteFormat::LittleEndian
    when :big
      IO::ByteFormat::BigEndian
    when :system
      IO::ByteFormat::SystemEndian
    else # This shouldn't happen
      raise "Endian type error"
    end
  end
end
