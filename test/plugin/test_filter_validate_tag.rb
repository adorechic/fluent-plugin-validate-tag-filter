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
end
