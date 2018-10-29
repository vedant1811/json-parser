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
    when '{'
      parse_hash(input)
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
    input_without_first_quotes = input.shift
    last_quotes_index = input_without_first_quotes.unparsed_string.index '"'
    string = input_without_first_quotes.unparsed_string[0...last_quotes_index]
    input_without_first_quotes.transform_to(last_quotes_index, string)
  end

  def parse_array(input)
    array = []
    unread = input

    while unread.first_char != ']'
      # error case. non terminating
      return input unless [',' , '['].include?(unread.first_char)

      unread = unread.shift
      # empty array
      break if unread.first_char == ']'

      unread = parse_object(unread)
      array << unread.object
    end

    unread.transform_to(0, array)
  end

  def parse_hash(input)
    hash = {}
    unread = input

    while unread.first_char != '}'
      # error case. non terminating
      return input unless [',' , '{'].include?(unread.first_char)

      unread = unread.shift
      # empty hash
      break if unread.first_char == '}'

      unread = parse_object(unread)
      key = unread.object.to_sym

      # error case
      return input unless ':' == unread.first_char
      unread = unread.shift

      unread = parse_object(unread)
      value = unread.object

      hash[key] = value
    end

    unread.transform_to(0, hash)
  end
end
