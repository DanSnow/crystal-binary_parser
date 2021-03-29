require "./_primary_type"

class BinaryParser
  # Declare a uint8 field
  #
  # ```
  # uint8 :value # name of field
  # ```
  macro uint8(name)
    _primary_type({{name}}, "u8")
  end
end
