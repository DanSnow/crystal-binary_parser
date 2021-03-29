require "./_primary_type"

class BinaryParser
  # Declare a int8 field
  #
  # ```
  # int8 :value # name of field
  # ```
  macro int8(name)
    _primary_type({{name}}, "i8")
  end
end
