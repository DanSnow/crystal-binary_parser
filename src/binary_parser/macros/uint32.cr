require "./_primary_type"

class BinaryParser
  # Declare a uint32 field
  #
  # ```crystal
  # uint32 :value # name of field
  # ```
  macro uint32(name)
    _primary_type({{name}}, "u32")
  end
end
