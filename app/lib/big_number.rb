class BigNumber
  def initialize(value)
    @value = value
  end

  def to_s(base)
    `#{@value}.toString(#{base})`
  end

  def plus(number, base: nil)
    if base.nil?
      BigNumber.new `#{@value}.plus(#{number})`
    else
      BigNumber.new `#{@value}.plus(#{number}, #{base})`
    end
  end

  def minus(number, base: nil)
    if base.nil?
      BigNumber.new `#{@value}.minus(#{number})`
    else
      BigNumber.new `#{@value}.minus(#{number}, #{base})`
    end
  end
end
