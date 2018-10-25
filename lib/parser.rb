require 'string'

module Parser

  # All the parse* methods take a @param input a ParsedObject
  # and @return a ParsedObject

  def parse_object(input)
    case input.first_char
    when '"'
      parse_string(input)
    when '['
      parse_array(input)
    else
      if input.first_char.numeric?
        parse_int(input)
      end
    end
  end

private
  def parse_int(input)
    int = input.unparsed_string.to_i
    input.transform_to(int.to_s.size - 1, int)
  end

  def parse_string(input)
    input_without_first_quotes = input.transform_to(0)
    last_quotes_index = input_without_first_quotes.unparsed_string.index '"'
    string = input_without_first_quotes.unparsed_string[0...last_quotes_index]
    input_without_first_quotes.transform_to(last_quotes_index, string)
  end

  def parse_array
    array = []



    array
  end
end
