class String
  def numeric?
    Float(self) != nil rescue false
  end
end

class Parser
  attr_reader :unparsed_string, :parsed_object

  def initialize(input)
    @unparsed_string = input
    @parsed_object = nil
    parse
  end

private
  def parse
    first_char = unparsed_string[0]

    @parsed_object =
    if first_char.numeric?
      parse_int
    end
  end

  def parse_int
    int = @unparsed_string.to_i
    @unparsed_string.sub! int.to_s, ''
    int
  end
end
