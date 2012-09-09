def describe description, &block
  Spec.new(block).evaluate!
end

class Spec
  def initialize block
    @block = block
  end

  def evaluate!
    instance_eval(&@block)
  end

  def it description, &block
    block.call
  end
end

class AssertionError < Exception
end

class Object
  def should &block
    DelayedAssertion.new self
  end

  def should_not
    InverseDelayedAssertion.new(self)
  end
end

class DelayedAssertion
  def initialize subject
    @subject = subject
  end

  def == other
    raise AssertionError unless @subject == other
  end
end

class InverseDelayedAssertion
  def initialize subject
    @subject = subject
  end

  def == other
    raise AssertionError if @subject == other
  end
end
