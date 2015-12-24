		#general structure of choices
		result = gets.to_i
		while true do
			if result == 1
				return "It's a one"
	
			
			elsif result == 2
				return "It's a 2"
				
			elsif result == 3
				return "It's a three"
				
			else 
				puts "Please make the proper input"
				result = gets.to_i
			end
		end