class StringCalculator
  def add(str)
    str.empty? ? 0 : str.split(',').reduce(0) { |sum, str_num| sum + str_num.to_i }
  end
end
