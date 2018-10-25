class String
  def numeric?
    Float(self) != nil rescue false
  end
end

class Parser
  attr_reader :unparsed_string, :parsed_object

  def initialize(input)
    @unparsed_string = input
    @parsed_object = parse
  end

private
  def parse
    first_char = unparsed_string[0]

    case first_char
    when '"'
      parse_string
    else
      if first_char.numeric?
        parse_int
      end
    end
  end

  def parse_int
    int = @unparsed_string.to_i
    @unparsed_string.sub! int.to_s, ''
    int
  end

  def parse_string
    @unparsed_string.slice! 0 # remove the first "
    last_quotes_index = @unparsed_string.index '"'
    string = @unparsed_string[0...last_quotes_index]
    @unparsed_string = @unparsed_string[(last_quotes_index + 1)..-1]
    string
  end
end
