system('clear')

words = []

File.open('/usr/share/dict/words', 'r') do |file|
  while line = file.gets
    words << line.chomp unless line =~ /[A-Z]/ || line.size > 8
  end
end

max = words.size
num = ARGV[0].to_i
num = 3 if num == 0

loop do
  puts "Press enter to generate a random #{num}-word combination"
  STDIN.gets

  results = []
  num.times { results << words[rand(max)] }

  puts "Your words: #{results.join(' ')}"
  puts
  puts "...for a total of #{results.join('').size} letters."
  puts
  puts 'Press enter to repeat.'

  STDIN.gets
  system('clear')
end

