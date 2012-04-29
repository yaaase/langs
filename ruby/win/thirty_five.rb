require 'rubygems'
require 'prime'
require 'memoize'

include Memoize

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

memoize(:problem_thirty_five)
puts problem_thirty_five