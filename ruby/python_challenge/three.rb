file = File.open("./source.txt")
lines = []
while line = file.gets
	lines << line.strip
end
key = {}
lines.each do |line|
	list = line.split(//)
	list.each do |char|
		if key[char] == nil
			key[char] = 1
		else
			key[char] += 1
		end
	end
end
puts key.sort_by{|k,v| v} # scramble of "equality"