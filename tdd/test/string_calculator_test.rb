require 'minitest/autorun'
require_relative '../lib/string_calculator'

class StringCalculatorTest < Minitest::Test
  def setup
    @string_calculator = ::StringCalculator.new
  end

  def test_empty_string
    assert_equal(0, @string_calculator.add(''))
  end

  def test_single_number_string
    assert_equal(1, @string_calculator.add('1'))
  end

  def test_another_single_number_string
    assert_equal(50, @string_calculator.add('50'))
  end

  def test_two_numbers_string
    assert_equal(3, @string_calculator.add('1,2'))
  end

  def test_another_two_numbers_string
    assert_equal(56, @string_calculator.add('4,52'))
  end
end
