require "./_primary_type"

class BinaryParser
  # Declare a uint64 field
  #
  # ```
  # uint64 :value # name of field
  # ```
  macro uint64(name)
    _primary_type({{name}}, "u64")
  end
end
