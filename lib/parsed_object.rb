class ParsedObject
  attr_reader :object, :unparsed_string

  def initialize(unparsed_string, object = nil)
    @unparsed_string = unparsed_string || ''
    @object          = object
  end

  def transform_to(parsed_till_index, object = nil)
    ParsedObject.new(unparsed_string[(parsed_till_index + 1)..-1], object)
  end

  # could be +nil+
  def first_char
    unparsed_string[0]
  end
end
