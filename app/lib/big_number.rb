class BigNumber
  def initialize(value)
    @value = value
  end

  def to_s(base)
    `#{@value}.toString(#{base})`
  end
end
