require 'minitest/autorun'
require_relative '../lib/string_calculator'

class StringCalculatorTest < Minitest::Test
  def setup
    @string_calculator = ::StringCalculator.new
  end

  def test_empty_string
    assert_equal(0, @string_calculator.add(''))
  end
end
