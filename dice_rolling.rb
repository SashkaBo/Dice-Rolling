require 'benchmark'

class Integer
  def factorial
    f = 1; for i in 1..self; f *= i; end; f
  end
end

def k_sum(k, n, p, s)
  (-1)**k * binomial_coef(n, k) * binomial_coef(p - s * k - 1, n - 1)
end

def binomial_coef(n, k)
  n.factorial / (k.factorial * (n - k).factorial)
end

def valid_input?(n, p, s)
  positive_integers?(n, p)
end

def positive_integers?(*numbers)
  numbers.each { |n| return false if !/\A\d+\z/.match(n) }
  true
end 

def calculate_probability(n, p, s)
  if p >= n && p <= n * s
    numerator = 0
    k_max = ((p - n) / s).floor
    for k in 0..k_max do
      numerator += k_sum(k, n, p, s)
    end

    denominator = s**n
    result = numerator.to_f / denominator
  end
  result ||= 0
  puts "Probability of your number is #{result}"
end

puts "Enter dice amount: "
n = gets.chomp
puts "Enter your number: "
p = gets.chomp

if valid_input?(n, p, 6)
  Benchmark.bm do |x|
    x.report { calculate_probability(n.to_i, p.to_i, 6) }
  end
else
  puts "Incorrect data!"
end
