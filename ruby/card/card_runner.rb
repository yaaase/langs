File.open("card.rb","r") { |c| while line = c.gets do puts(eval(line)) end }
