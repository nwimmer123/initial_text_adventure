def adventure

	luck = [1,2,3,4,5,6,7,8,9,10]

	def stat_generator
		
		stat = Random.new
		strength = stat.rand(1..10)
		intelligence = stat.rand(1..10)
		dexterity = stat.rand(1..10)
		vitality = stat.rand(1..10)
		beauty = stat.rand(1..10)
		gold = 0
		xp = 0 

		puts "Please review your stats. 10 is the max."
		puts ""
	
		$stats = {
		strength: strength,
		intelligence: intelligence,
		dexterity: dexterity,
		vitality: vitality,
		beauty: beauty,
		gold: gold,
		xp: xp,
		inventory: [],
		level: 1
		}

		puts $stats
		
	end

	def level_up_check(level)

		if $stats[:level] == 1 && $stats[:xp] > 50
			level_up
			return
		elsif $stats[:level] == 2 && $stats[:xp] > 125
			level_up
			return
		elsif $stats[:level] == 3 && $stats[:xp] > 225
			level_up
			return
		elsif $stats[:level] == 4 && $stats[:xp] > 375
			level_up
			return
		end
	end

	def level_up
		check = "repeat"
		while check == "repeat" do
			puts "You have leveled up. Vitality increases! Choose another skill to increase."
			$stats[:level] += 1
			$stats[:vitality] += 2
			puts "1) strength"
			puts "2) intelligence"
			puts "3) dexterity"
			puts "4) vitality"
			puts "5) beauty"
			check = gets.to_i
			if check == 1
				$stats[:strength] += 1
			elsif check == 2
				$stats[:intelligence] += 1
			elsif check == 3
				$stats[:dexterity] += 1
			elsif check == 4
				$stats[:vitality] += 1
			elsif check == 5
				$stats[:beauty] += 1
			else
				puts "please enter the correct input"
				check = "repeat"
			end

		end
		puts "Here are your new stats! #{$stats}"
		return		
	end

	# checks if character is dead
	def death_check
		if $stats[:strength] < 1 || $stats[:intelligence] < 1 || $stats[:dexterity] < 1 || $stats[:vitality] < 1 || $stats[:beauty] < 1 
			return true
		else
			return
		end
	end

	def death
		puts "THE END!"
		puts ""
		puts "1) If you would like to play again."
		puts "2) If you are done for now."
		result = gets.to_i
		check = "repeat"
		while check == "repeat" do
			if result == 1
				adventure
			elsif result == 2
				return true
			else 
				puts "Please make the proper input"
				check = "repeat"
				result = gets.to_i
			end
		end
	end

	puts "What is your name brave adventurer?"
	puts ""
	player_name = gets.chomp
	puts "Are you prepared for a grand adventure #{player_name}?"
	puts ""
	puts stat_generator

	result = 2
	while result == 2 
		puts "Here is your first game choice. Enter just the number to the left of the choice to make your selection."
		puts "If you would like to keep your character,"
		puts "1) Yes, I would like to keep my amazing stats!"
		puts "2) No, this character is the worst, make me a new one!"
		puts ""

		result = gets.to_i

		if result == 1
			puts "May you find success!"
			puts ""
		elsif result == 2
			puts stat_generator
		else
			puts "Please make the proper input"
			puts ""
			result = 2
		end
	end

	puts "You've heard that there is a cave nearby filled with weak little gobins who have been terrorizing the local peasants who are even weaker and punier. Sadly, you lost a lot of coin playing Diamondback the other night and you really need to refill your personal cofers, and you're still pissed about your loss, so nothing quite like doing some ultra-violence on some puny goblins to make you feel better about your self."
	puts ""
	puts "As you approach the entrance to the dank cave, a cold, foul wind wafts out. A chill goes through your bones and a sense of grand foreboding fills your soul."
	puts ""
	puts "1) This is a direct sign from the all mighty Thormidal!! It is a sign that I should return to the village and renounce my sinfull ways!"
	puts "2) Hmmm, this sense of forebodeing makes me nervous, I shall enter as silently as I can..."
	puts "3) Paaah, this is naught but foolishness, I shall let forth a great war cry so all may know my rath. #{player_name} fears nothing!!!"
	
	result = gets.to_i
	check = "repeat"

	while check == "repeat"		
		if result == 1
			$stats[:vitality] -= 20

			if death_check 
				puts "ahhhh you're sossss dead!!!"
				if death
					return
				end
			end
			puts 
			#return "You return to the village, feeling a little foolish. What made you filled with such bloodthristy greed in the first place? Perhaps it was the curse of Udenas. Well, at least the spell has passed by and the peace of Thormidal has filled you once again.  Some meditation in the gardens of peace is needed."
		elsif result == 2
			puts "You sneak quietly into the gloom of the cave."
			puts ""
			if $stats[:dexterity] > 5
				puts "You see a goblin skulking in the gloom ahead with a bow and arrow, watching the entrance carefully. Good thing you came in quietly! You sneak up behind it and stab it in the back. It gives a gasp and falls over dead. You feel through its pockets and find 1 gold piece and an iron key."
				puts ""
				$stats[:gold] += 1
				$stats[:xp] += 10
				$stats[:inventory] << "iron key"
				break
			elsif $stats[:dexterity] > 2
				puts "As you try to sneak into the gloomy cave, you step on a stick. It snaps and the goblin spins and takes a shot at you while hollering an alarm."
				puts ""
					luck = Random.new
					luck = luck.rand(1..10)
					if luck > 5
						$stats[:gold] += 1
						$stats[:xp] += 10
						$stats[:inventory] << "iron key"
						puts "The arrow wizzes over your head. As the goblin grabs another arrow, he fumbles it in his fear, giving you time enough to thrust your knife into its belly.  He gives a cry and blood gurgles up between his lips as he dies. You feel through its pockets and find 1 gold piece and an iron key."
						puts ""
						break
						
					else 
						puts "The arrow thunks into your thigh and a searing pain shoots through your body." 
						puts ""
						$stats[:vitality] -= 2
						$stats[:dexterity] -= 1
						if $stats[:vitality] < 0 || $stats[:dexterity] < 0
							return "You colapse to the ground holding your leg. The goblin walks over, knife in hand and a leer on its face. He laughs as he opens your thrat and you feel no more ..."
						else
						$stats[:gold] += 1
						$stats[:xp] += 10
						$stats[:inventory] << "iron key"
						puts "You reach into your belt and grab a knife, hurtling into the goblins eye. It's hand fly to its face and then it collapses in death. You feel through its pockets and find 1 gold piece and an iron key."
						puts ""
						break
						end

					end
			else
			return "You trip on a gnarled root as you clumsily feel your way into the darkness. You fall head long into a pit, impaling yourself on a staligmite."
			end

		elsif result == 3
			luck = Random.new
			luck = luck.rand(1..10)
			puts "With a roar you plunge headlong into the darkness, you hear the scretches of goblins in front of you. Prepare for battle!"
			puts ""
			if ($stats[:dexterity] > 6 && $stats[:strength] > 5) || (luck > 3)
				$stats[:gold] += 1
				$stats[:xp] += 10
				$stats[:inventory] << "iron key"
				puts "You see a goblin in the gloom readying bow and arrow. You run up to him and ram your sword into his throat. Afer looting his body you find a gold piece and an iron key."
				puts ""
				break
			elsif luck > 0
				puts "An arrow thunks into your thigh and a searing pain shoots through your body." 
				puts ""
					$stats[:vitality] -= 2
					$stats[:dexterity] -= 1
					if $stats[:vitality] < 0 || $stats[:dexterity] < 0
						return "You colapse to the ground holding your leg. A goblin walks over, knife in hand and a leer on its face. He laughs as he opens your throat and you feel no more ..."
					else
					$stats[:gold] += 1
					$stats[:xp] += 10
					$stats[:inventory] << "iron key"
					puts "You spy the archer, a goblin, high in the cave. He's readying another shot. You reach into your belt and grab a knife, hurtling into the goblins eye. It's hand fly to its face and then it collapses in death. You climb up to it and feel through its pockets finding 1 gold piece and an iron key."
					puts ""
					break
					end
			end

		else
			check = "repeat"
			puts "Please enter a correct response."
			result = gets.to_i
		end
	end

	puts "Stats reminder: #{$stats}"
	puts ""

	puts "You survey the cave and see a tunnel leading down."
	puts ""
	puts "1) I've had enough of this. I'm going back to the tavern. I can get back in on a game of Diamondback and win all my money back with 1 gold piece."
	puts "2) Head down the tunnel."
	puts ""

	result = gets.to_i
	check = "repeat"
	while check == "repeat" do
		if result == 1
			luck = Random.new
			luck = luck.rand(1..10)
			if luck > 8
				return "You return to the tavern with #{$stats[:gold]} gold pieces, vastlt exagerrated tales of your martial prowess and proced to have the best Diamondback run in histroy. You emerge as the wealthiest person around!!"
			elsif luck > 3
				return "You return to town, and proced to lose your gold in about 10 minutes. Back to square one"
			end
		elsif result == 2
			puts "You travel down into the dark tunnel. At least you have a torch."
			break
		else 
			puts "Please make the proper input"
			check = "repeat"
			result = gets.to_i
		end
	end


		# luck check
		# luck = Random.new
		# luck = luck.rand(1..10)
		# if luck > 5

		#general structure of choices
		#check = "repeat"
		# while check == "repeat" do
		# 	if result == 1
		# 		puts "It's a one"
		# 		break
		# 	elsif result == 2
		# 		puts "It's a 2"
		# 		break
		# 	elsif result == 3
		# 		puts "It's a three"
		# 		break
		# 	else 
		# 		puts "Please make the proper input"
		# 		check = "repeat"
		# 		result = gets.to_i
		# 	end
		# end

end

puts adventure


