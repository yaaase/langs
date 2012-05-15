class Fib

  def nth_fib n
    return 1 if n == 1 || n == 2
    return nth_fib(n - 1) + nth_fib(n - 2)
  end

end
