require 'helper'

class ValidateTagFilterTest < Test::Unit::TestCase
  def setup
    if defined?(Fluent::Filter)
      Fluent::Test.setup
    else
      omit("Use Fluentd v0.12 or later.")
    end
  end

  def create_driver(conf: '', tag: 'test')
    Fluent::Test::FilterTestDriver.new(Fluent::ValidateTagFilter, tag).configure(conf)
  end

  def test_valid_queue
    assert_allow_tag
  end

  def test_max_length
    assert_allow_tag(conf: 'max_length 5', tag: 'abcde')
    assert_deny_tag(conf: 'max_length 5', tag: 'abcdef')
    assert_allow_tag(conf: '', tag: 'a' * 250)
  end

  def test_regexp
    assert_allow_tag(conf: 'regexp1 \Atest.[0-9]{1,3}.bar\z', tag: 'test.0.bar')
    assert_deny_tag(conf: 'regexp1 \Atest.[0-9]{1,3}.bar\z', tag: 'test.0000.bar')
    assert_deny_tag(conf: 'regexp1 \Atest.[0-9]{1,3}.bar\z', tag: 'test.hoge.bar')
    assert_allow_tag(conf: ['regexp1 \Atest.[0-9]{1,3}.bar\z', 'regexp2 test.1'].join("\n"), tag: 'test.1.bar')
    assert_deny_tag(conf: ['regexp1 \Atest.[0-9]{1,3}.bar\z', 'regexp2 test.1'].join("\n"), tag: 'test.0.bar')
  end

  private

  def assert_allow_tag(conf: '', tag: 'test')
    d = create_driver(conf: conf, tag: tag)
    d.run do
      d.filter("foo" => 1)
    end
    assert_equal({ "foo" => 1 }, d.filtered_as_array[0][2])
  end

  def assert_deny_tag(conf: '', tag: 'test')
    d = create_driver(conf: conf, tag: tag)
    d.run do
      d.filter("foo" => 1)
    end
    assert_equal([], d.filtered_as_array)
  end
end
