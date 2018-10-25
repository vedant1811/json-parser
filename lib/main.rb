require 'parser'

def parse(input)
  parser = Parser.new input

  [parser.parsed_object, parser.unparsed_string]
end
