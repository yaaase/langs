class Foo
  attr_reader :missed_methods

  def initialize *args
    @args, @missed_methods = [], []
    args.each do |arg|
      @args << arg
    end
  end

  def contains? x
    @args.include? x
  end

  def method_missing name, *args, &block
    @missed_methods << name.to_sym
    super
  end

end
