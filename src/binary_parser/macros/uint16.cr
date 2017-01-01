require "./_primary_type"

class BinaryParser
  # Declare a uint16 field
  #
  # ```crystal
  # uint16 :value # name of field
  # ```
  macro uint16(name)
    _primary_type({{name}}, "u16")
  end
end
