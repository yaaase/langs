class Calculator
  class << self

    def add(*args)
      args.inject(0,&:+)
    end

    def multiply(*args)
      args.inject(1,&:*)
    end

  end
end
