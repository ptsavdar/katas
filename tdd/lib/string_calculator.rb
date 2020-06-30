class StringCalculator
  def add(str)
    str.empty? ? 0 : str.split(/[,\\n]/).map(&:to_i).reduce(0, :+)
  end
end
