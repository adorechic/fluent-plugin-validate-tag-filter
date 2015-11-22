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
    d = create_driver
    d.run do
      d.filter("foo" => 1)
    end

    assert_equal({ "foo" => 1 }, d.filtered_as_array[0][2])
  end

  def test_max_length
    d = create_driver(conf: 'max_length 5', tag: 'abcde')
    d.run do
      d.filter("foo" => 1)
    end
    assert_equal({ "foo" => 1 }, d.filtered_as_array[0][2])

    d = create_driver(conf: 'max_length 5', tag: 'abcdef')
    d.run do
      d.filter("foo" => 1)
    end
    assert_equal([], d.filtered_as_array)
  end

  def test_pattern
    d = create_driver(conf: 'pattern \Atest.[0-9].bar\z', tag: 'test.0.bar')
    d.run do
      d.filter("foo" => 1)
    end
    assert_equal({ "foo" => 1 }, d.filtered_as_array[0][2])

    d = create_driver(conf: 'pattern \Atest.[0-9].bar\z', tag: 'test.hoge.bar')
    d.run do
      d.filter("foo" => 1)
    end
    assert_equal([], d.filtered_as_array)
  end
end
