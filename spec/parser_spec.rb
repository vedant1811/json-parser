require 'main'

RSpec.describe 'Parser' do

  it do
    expect(parse '123').to eq [123, '']
  end

  it do
    expect(parse '123abc').to eq [123, 'abc']
  end

  it do
    expect(parse '"123"abc').to eq ['123', 'abc']
  end

  it do
    expect(parse '"abc"[123]').to eq ['abc', '[123]']
  end

  it do
    expect(parse '[1,2,3]').to eq [[1,2,3], '']
  end

  it do
    expect(parse '[1,2,3][abc]').to eq [[1,2,3], '[abc]']
  end

  it do
    expect(parse '[[[]]]').to eq [[[[]]], '']
  end

  it do
    expect(parse '[[],[[]]]').to eq [[[],[[]]], '']
  end

  it do
    expect(parse '["a",123,["x","y"]]').to eq [["a", 123, ["x", "y"]], '']
  end

  it do
    expect(parse '{"a":1}').to eq [{"a": 1}, '']
  end

  it do
    expect(parse '{"a":1,"b":2}').to eq [{"a":1,"b":2},'']
  end

  it do
    expect(parse '{}').to eq [{}, '']
  end

  it do
    expect(parse '{}abc').to eq [{}, 'abc']
  end

  it do
    expect(parse '{"a":[[[]]]}').to eq [{"a":[[[]]]}, '']
  end

  it do
    expect(parse '{"a":1,"b":[1,2,3],"c":{"d":1}}').to eq [{"a":1,"b":[1,2,3],"c":{"d":1}}, '']
  end

end
