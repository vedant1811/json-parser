"""
We have to implement a json parser (in less than 100 lines) that can parse arbitrary json string with the following limitations:

    - json primitives can be types: number, string
    - json data structures - list and dict which can be arbitrary nested
    - we don't support whitespaces between tokens.
    - we don't support escape codes in strings.

Examples of the correct parse for some json strings:

'123' - 123 (number)

'"123"' - "123" (string)

'[1,2,"a"]' - [1,2,"a"] (python list)

Remember, json strings are always double quoted. So in the second example, we are given a string which is further enclosed in double quotes and hence
we must return a python string as output.

How does the parser work?

The driver function and the starting point of this parser is the parse function. Parse function looks at the first character of its
input and simply calls the corresponding functions. The semantics of the parse function and other parse_<type> functions are as
follows:

- input is string
- output is a two element array where:
    - first element is the data structure for the parsed input string
    - second element is a string which is the part of the input string which has not been parsed

To give you a few example:
parse('123abc') = (123, "abc")

Here once the non-digit corrects are encounterd, the parsing stops and the remaining string is returned in the second part of the output.

parse('"123"abc') = ("123", "abc")

Here the parsing stops once the the closing double quote (") is encountered and the rest of string is returned as it is.


Hints:
 - We have given the implementation of parse_number as an example. Try implementing the parse_string function first and then move on to list and finally dict.
 - you should never need to call parse_<type> function from another parse_<type> function
 - For the list implementation, we need to parse arbitrary values inside lists and even nested lists of lists containing dictionaries.
    - But we already have a function which can parse arbitrary values. So you shouldn't have to parse values inside list.
    - parse_list function is about 10-15 lines of code. If you are writing more you are doing it wrong!

"""

class Token:
    STRING_BEGIN = STRING_END = '"'
    LIST_BEGIN = '['
    LIST_END = ']'
    LIST_DELIMITER = DICT_DELIMITER = ','
    DICT_SYMBOL = ':'
    DICT_BEGIN = '{'
    DICT_END = '}'
    WHITESPACE = ' '
    NEWLINE = '\n'

class ParserException(Exception):
    pass

def isdigit(s):
    return s in "01234567890"

def parse_string(string):
    pass

def parse_number(string):
    number = []
    for s in string:
        if s in "01234567890":
            number.append(s)
        else:
            break
    return int("".join(number)), string[len(number):]

def parse_list(string):
    pass

def parse_dict(string):
    pass

def parse(string):
    s = string[0]
    if s == Token.STRING_BEGIN:
        return parse_string(string)
    elif s == Token.LIST_BEGIN:
        return parse_list(string)
    elif s == Token.DICT_BEGIN:
        return parse_dict(string)
    elif isdigit(s):
        return parse_number(string)
    else:
        raise ParserException("Unknown Token: %s" % s)

assert parse('123') == (123, '')
assert parse('123abc') == (123, 'abc')
assert parse('"123"abc') == ('123', 'abc')
assert parse('"abc"[123]') == ('abc', '[123]')
assert parse('[1,2,3]') == ([1,2,3], '')
assert parse('[1,2,3][abc]') == ([1,2,3], '[abc]')
assert parse('[[[]]]') == ([[[]]], '')
assert parse('[[],[[]]]') == ([[],[[]]], '')
assert parse('["a",123,["x","y"]]') == (["a", 123, ["x", "y"]], '')
assert parse('{"a":1}') == ({"a": 1}, '')
assert parse('{"a":1,"b":2}') == ({"a":1,"b":2},'')
assert parse('{}') == ({}, '')
assert parse('{}abc') == ({}, 'abc')
assert parse('{"a":[[[]]]}') == ({"a":[[[]]]}, '')
assert parse('{"a":1,"b":[1,2,3],"c":{"d":1}}') == ({"a":1,"b":[1,2,3],"c":{"d":1}}, '')
