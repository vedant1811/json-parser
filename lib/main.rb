require 'parser'
require 'parsed_object'

include Parser

def parse(input)
  unparsed = ParsedObject.new(input)
  parsed_object = parse_object(unparsed)

  [parsed_object.object, parsed_object.unparsed_string]
end
