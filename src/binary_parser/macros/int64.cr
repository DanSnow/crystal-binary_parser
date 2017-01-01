require "./_primary_type"

class BinaryParser
  # Declare a int64 field
  #
  # ```crystal
  # int64 :value # name of field
  # ```
  macro int64(name)
    _primary_type({{name}}, "i64")
  end
end
