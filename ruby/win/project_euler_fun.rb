require 'prime'
require './collatz'

class ProjectEuler

  def problem_one
    sum = 0
    1.upto(999) { |x|
      sum += x if x % 3 == 0 || x % 5 == 0
    }
    sum
  end

  def problem_two
    sum = 0
    a, b = 1, 1
    while b < 4000000
      a, b = b, a + b
      sum += b if b.even?
    end
    sum
  end

  def problem_three
    n = 600851475143
    Prime.each do |p|
      break if n.prime?
      n /= p while n % p == 0
      n = p if n < p
    end
    n
  end

  def problem_four
    x = 0
    100.upto(999) { |a|
      100.upto(999) { |b|
        x = a*b if (a*b).to_s == (a*b).to_s.reverse && x < a*b
      }
    }
    x
  end

  def problem_five
    (1..20).inject(1) { |x, n| x.lcm(n) }
  end

  def problem_six
    (1..100).inject(0,&:+) ** 2 - (1..100).inject(0) { |x, n| x + n*n }
  end

  def problem_seven
    counter = 1
    Prime.each do |p|
      return p if counter == 10001
      counter += 1
    end
  end

  def problem_eight
    n =  """73167176531330624919225119674426574742355349194934
    96983520312774506326239578318016984801869478851843
    85861560789112949495459501737958331952853208805511
    12540698747158523863050715693290963295227443043557
    66896648950445244523161731856403098711121722383113
    62229893423380308135336276614282806444486645238749
    30358907296290491560440772390713810515859307960866
    70172427121883998797908792274921901699720888093776
    65727333001053367881220235421809751254540594752243
    52584907711670556013604839586446706324415722155397
    53697817977846174064955149290862569321978468622482
    83972241375657056057490261407972968652414535100474
    82166370484403199890008895243450658541227588666881
    16427171479924442928230863465674813919123162824586
    17866458359124566529476545682848912883142607690042
    24219022671055626321111109370544217506941658960408
    07198403850962455444362981230987879927244284909188
    84580156166097919133875499200524063689912560717606
    05886116467109405077541002256983155200055935729725
    71636269561882670428252483600823257530420752963450"""
    best = 0
    index = 0
    (n.size - 5).times do
      sub = n.slice(index..(index+4))
      sub_product = sub.split(//).map(&:to_i).inject(1,&:*)
      best = sub_product if best < sub_product
      index += 1
    end
    best
  end

  def problem_nine
    1.upto(1000) { |a|
      (a+1).upto(1000) { |b|
        c = Math.sqrt(a**2 + b**2).to_i
        next if c**2 != a**2 + b**2
        break if a + b + c > 1000
        return a*b*c if a+b+c == 1000
      }
    }
  end

  def problem_ten
    sum = 0
    Prime.each(2000000) do |p|
      sum += p
    end
    sum
  end

  def problem_fourteen
    Collatz.new.problem_fourteen
  end

  def problem_sixteen
    (2**1000).to_s.split(//).map(&:to_i).inject(0,&:+)
  end

  def problem_twenty
    (1..100).inject(1,&:*).to_s.split(//).map(&:to_i).inject(0,&:+)
  end

  def problem_twenty_five
    a, b, counter = 1, 1, 2
    while b.to_s.size < 1000
      a, b = b, a + b
      counter += 1
    end
    counter
  end

  def problem_thirty_five # slow as fuck
    counter = 0
    Prime.each(1_000_000) do |p|
      p = p.to_s
      set = []
      p.size.times do
        p << p.slice!(0)
        set << p.to_i
      end
      counter += 1 if !set.map(&:prime?).include?(false)
    end
    counter
  end

  def problem_thirty_six
    sum = 0
    1.upto(1000000) { |n|
      sum += n if n.to_s == n.to_s.reverse && n.to_s(base=2) == n.to_s(base=2).reverse
    }
    sum
  end

  def problem_forty_eight
    (1..1000).inject(0){ |s, x| s + x**x }.to_s[-10..-1]
  end

end

p = ProjectEuler.new