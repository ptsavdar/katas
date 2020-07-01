class StringCalculator
  def add(str)
    return 0 if str.empty?

    numbers(str).then(&method(:raise_negatives)).then(&method(:remove_bigger_than_1000)).sum
  end

  private

  DEFAULT_DELIMITER_REGEX = %r{[,\\n]}

  # CUSTOM_DELIMITER_REGEX BREAKDOWN:
  # (?:(?:\[?([^\]]+)\]?) => Group 1: captures all single custom delimiters e.g. ; but also [;;;]
  # ((?:\[[^\]]+\])*)) => Group 2: captures all mutliple custom delimiters e.g. [***][;;;][---]
  CUSTOM_DELIMITER_REGEX = %r{\A//(?:(?:\[?([^\]]+)\]?)|((?:\[[^\]]+\])*))\\n}

  MULTIPLE_DELIMITER_REGEX = %r{\[([^\]]+)\]+}

  def numbers(str)
    split(str).map(&:to_i)
  end

  def split(str)
    delimiter = delimiter(str)

    str.gsub(CUSTOM_DELIMITER_REGEX, '').split(delimiter)
  end

  def raise_negatives(numbers)
    negatives = numbers.filter(&:negative?)
    raise "negatives not allowed #{negatives.join(', ')}" if negatives.any?

    numbers
  end

  def remove_bigger_than_1000(numbers)
    numbers.filter { |n| n <= 1000 }
  end

  def delimiter(str)
    multiple_delimiters_match = str[CUSTOM_DELIMITER_REGEX, 2]
    return Regexp.new('(' + multiple_delimiters_match.scan(MULTIPLE_DELIMITER_REGEX).flatten.map { |del| Regexp.quote(del) }.join('|') + ')') if multiple_delimiters_match
    
    str[CUSTOM_DELIMITER_REGEX, 1] || DEFAULT_DELIMITER_REGEX
  end
end
