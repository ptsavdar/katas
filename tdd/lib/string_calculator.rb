class StringCalculator
  def add(str)
    str.empty? ? 0 : split(str).map(&:to_i).then(&method(:valid?)).then(&method(:up_to_1000)).sum
  end

  private

  DEFAULT_DELIMITER_REGEX = %r{[,\\n]}
  CUSTOM_DELIMITER_REGEX = %r{\A//\[?([^\]]+)\]?\\n}

  def split(str)
    delimiter = str[CUSTOM_DELIMITER_REGEX, 1] || DEFAULT_DELIMITER_REGEX

    str.gsub(CUSTOM_DELIMITER_REGEX, '').split(delimiter)
  end

  def valid?(numbers)
    negatives = numbers.filter(&:negative?)
    raise "negatives not allowed #{negatives.join(', ')}" if negatives.any?

    numbers
  end

  def up_to_1000(numbers)
    numbers.filter { |n| n <= 1000 }
  end
end
