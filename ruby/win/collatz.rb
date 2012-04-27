class Collatz
  attr_reader :hash

  def initialize
    @hash = {}
  end

  def chain_length(n)
    start, count = n, 1
    while n != 1
      if n.even?
        n /= 2
      elsif n.odd?
        n = n*3 + 1
      end
      if @hash[n] != nil
        @hash[start] = @hash[n] + count
        return @hash[n] + count
      end
      count += 1
    end
    @hash[start] = count
    return count
  end

  def problem_fourteen
    max, best, longest, n = 1_000_000, 0, 0, 1
    while n < max
      current = chain_length(n)
      longest, best = current, n if longest < current
      n += 1
    end
    best
  end

end
