		result = gets.to_i
		check = "repeat"
		while check == "repeat" do
			if result == 1
				return "It's a one"
				
			elsif result == 2
				return "It's a 2"
				
			elsif result == 3
				return "It's a three"
				
			else 
				puts "Please make the proper input"
				check = "repeat"
				result = gets.to_i
			end
		end