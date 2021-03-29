require "./_primary_type"

class BinaryParser
  #
  # Declare a int16 field
  #
  # ```
  # int16 :value # name of field
  # ```
  macro int16(name)
    _primary_type({{name}}, "i16")
  end
end
