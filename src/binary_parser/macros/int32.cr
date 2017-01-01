require "./_primary_type"

class BinaryParser
  # Declare a int32 field
  #
  # ```crystal
  # int32 :value # name of field
  # ```
  macro int32(name)
    _primary_type({{name}}, "i32")
  end
end
