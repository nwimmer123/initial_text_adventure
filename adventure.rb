#array's to be used throughout 

@luck = [1,2,3,4,5,6,7,8,9,10]

@enemy_adjective =["smelly", "foul", "warty", "grotesque", "carbuncular", "shrieking", "mangy", "vile", "glum", "slimey", "repugnant", "flatulent"]

@melee_body_part =["chest", "abdomen", "arm", "thigh", "face", "gut", "ribs", "armpit", "sholder"]

	#########################
	#                       #
	#       MONSTER AND     #
	#  CHARACTER GENERATORS #
	#                       #
	#########################

def goblin_generator
	
	stat = Random.new
	@goblin = {
	name: "goblin",
	strength: stat.rand(3..5),
	intelligence: stat.rand(1..4),
	dexterity: stat.rand(4..8),
	vitality: stat.rand(1..3),
	beauty: stat.rand(1..2),
	gold: stat.rand(1..3),
	xp_value: 10,
	weapon: "short sword"
	}

end

def stat_generator
	
	stat = Random.new
	@stats = {
	strength: stat.rand(1..10),
	intelligence: stat.rand(1..10),
	dexterity: stat.rand(1..10),
	vitality: stat.rand(1..10),
	beauty: stat.rand(1..10),
	gold: 0,
	xp: 0,
	level: 1,
	inventory: []
	}

	puts "Please review your stats. 10 is the max."
	puts ""
	puts @stats
	
end
	
	#################
	#               #
	# CONTROL LOGIC #
	#               #
	#################

def level_up_check(level)

	if (@stats[:level] == 1 && @stats[:xp] > 50)
		level_up
	elsif (@stats[:level] == 2 && @stats[:xp] > 125)
		level_up
	elsif (@stats[:level] == 3 && @stats[:xp] > 225)
		level_up
	elsif (@stats[:level] == 4 && @stats[:xp] > 375)
		level_up
	end
end

def level_up
	check = "repeat"
	while check == "repeat" do
		puts "You have leveled up. Vitality increases! Choose another skill to increase."
		@stats[:level] += 1
		@stats[:vitality] += 2
		puts "1) strength"
		puts "2) intelligence"
		puts "3) dexterity"
		puts "4) vitality"
		puts "5) beauty"
		check = gets.to_i
		if check == 1
			@stats[:strength] += 1
		elsif check == 2
			@stats[:intelligence] += 1
		elsif check == 3
			@stats[:dexterity] += 1
		elsif check == 4
			@stats[:vitality] += 1
		elsif check == 5
			@stats[:beauty] += 1
		else
			puts "please enter the correct input"
			check = "repeat"
		end

	end
	puts "Here are your new stats! #{@stats}"
	return		
end

def death_check
	if (@stats[:strength] < 1 || @stats[:intelligence] < 1 || @stats[:dexterity] < 1 || @stats[:vitality] < 1 || @stats[:beauty] < 1)
		return true
	else
		return
	end
end

def death
	puts "\nTHE END!\n\n"
	puts "1) If you would like to play again."
	puts "2) If you are done for now."
	result = gets.to_i
	check = "repeat"
	while check == "repeat" do
		if result == 1
			return adventure(@goblin, @stats, @enemy_adjective, @melee_body_part, @luck)
		elsif result == 2
			return 
		else 
			puts "Please make the proper input"
			check = "repeat"
			result = gets.to_i
		end
	end
end

def monster_death?(monster, enemy_adjective)
	if monster[:vitality] < 1
		puts "With a shiver, the #{@enemy_adjective.sample} #{monster[:name]} collapses in a heap."
		return monster_death(monster, @stats, @enemy_adjective)
	else
		return
	end
end

def monster_death(monster, character, enemy_adjective)
	character[:xp] += monster[:xp_value]
	character[:gold] += monster[:gold]
	puts "A quick check of the #{@enemy_adjective.sample} #{monster[:name]}'s body yields #{monster[:gold]} gold pieces.\n\n"
	puts "stats reminder #{@stats}"
	level_up_check(@stats[:level])
end


def attack(monster, character, enemy_adjective, melee_body_part, luck)
	enemy_adjective = @enemy_adjective.sample
	puts "The #{enemy_adjective} #{monster[:name]} attacks! Swinging it's #{monster[:weapon]}!\n\n"
	@luck = Random.new
	luck = @luck.rand(1..10)
	puts "player luck #{luck}"
	injury = melee_body_part.sample
	if (monster[:dexterity] > character[:dexterity] && luck < 8)
		puts "The #{enemy_adjective} #{monster[:name]}'s #{monster[:weapon]} slips past your defense, slashing against your #{injury}.\n\n"
		character[:vitality] = character[:vitality] - monster[:strength]
		if death_check
			puts "You place a hand to your #{injury}, and see blood welling up. As you see your life flee from you, a sense of panic overcomes you. As you drop to a knee overcome by weakness you feel blades slicing into your body and then you know no more."
			return death
		end
	else 
		puts "As the #{enemy_adjective} #{monster[:name]} attacks, you slip your sword in past its guard slicing it in the #{melee_body_part.sample}.\n\n"
		monster[:vitality] = monster[:vitality] - character[:strength]
		monster_death?(monster, @enemy_adjective)
	end
	@current_monster = monster
	if monster[:vitality] > 0 && character[:vitality] > 0
		return combat(@current_monster, @stats, luck, enemy_adjective, melee_body_part)
	end
end

def parry(monster, character, enemy_adjective, melee_body_part, luck)
	enemy_adjective = @enemy_adjective.sample
	puts "goblin #{monster}"
	puts "character #{character}"
	puts "You raise your sword, meeting the #{enemy_adjective} #{monster[:name]}'s attack with a clash of steel.\n\n"
	@luck = Random.new
	luck = @luck.rand(1..10)
	injury = @melee_body_part.sample
	if (monster[:intelligence] > character[:intelligence] && luck < 4)
		puts "The #{enemy_adjective} #{monster[:name]}'s #{monster[:weapon]} glances off your sword, grazing your #{injury}\n\n"
		character[:vitality] = (character[:vitality] - (monster[:strength]/2))
		if death_check
			puts "You place a hand to your #{injury}, and see blood welling up. As you see your life flee from you, a sense of panic overcomes you. As you drop to a knee overcome by weakness you feel blades slicing into your body and then you know no more.\n\n"
			return death
		end
	else
		puts "You see an opening in the #{enemy_adjective} #{monster[:name]}'s guard and you make your move. Scoring a light blow on the #{monster[:name]}'s #{melee_body_part.sample}\n\n"
		monster[:vitality] = monster[:vitality] - (character[:strength]/2)
		monster_death?(monster, @enemy_adjective)
	end
	@current_monster = monster
	if monster[:vitality] > 0 && character[:vitality] > 0
		return combat(@current_monster, @stats, luck, enemy_adjective, melee_body_part)
	end
end

def run_away(monster, character, luck)
	puts @stats
	@luck = Random.new
	luck = @luck.rand(1..10)
	puts "Realizing that you are hard pressed you turn and run from the #{monster[:name]}. It takes a swing and half heartedly runs after you. "
	if ((monster[:dexterity] > character[:dexterity]) && luck < 4)
		character[:vitality] = character[:vitality] - monster[:strength]
		if death_check
			puts "You feel hard steel sink into your back and you realize that the end is nigh."
			return death
		end
	end
end 

def combat(monster, character, luck, enemy_adjective, melee_body_part)	
	current_monster = monster
	puts "The #{@enemy_adjective.sample} #{monster[:name]} approaches with its #{monster[:weapon]} drawn. Murder in its eyes.\n\n"
	puts "1) You ready your weapon for battle and attack uttering a yell as you go for an all out assault of fury, throwing caution to the wind."
 	puts "2) Best to approach this battle with care. I shall parry it's initial charge and look for an openeing in which to strike."
	puts "3) Run away!!!!!"
	result = gets.to_i
	puts ""
	check = "repeat"
	while check == "repeat" do
		if result == 1
			return attack(current_monster, character, @enemy_adjective, @melee_body_part, @luck)
		elsif result == 2
			return parry(current_monster, character, @enemy_adjective, @melee_body_part, @luck)
		elsif result == 3
			return run_away(current_monster, character, @luck)
		else 
			puts "Please make the proper input"
			check = "repeat"
			result = gets.to_i
		end
	end


end

	#############
	#           #
	# GAME PLAY #
	#           #
	#############

def return_to_tavern
	@luck = Random.new
	luck = @luck.rand(1..10)
	if luck > 8
		puts "You return to the tavern with #{@stats[:gold]} gold pieces, vastly exagerrated tales of your martial prowess and proced to have the best Diamondback run in histroy. You emerge as the wealthiest person around!!"
		return death
	else
		puts "You return to town, and proced to lose your gold in about 10 minutes. Back to square one"
		return death
	end
end

def torch?

	puts "Would you like to light your torch?\n\n1) Yes\n2) No"
	result = gets.to_i
	check = "repeat"
	#while check == "repeat" do
		if result == 1
			puts "You light your torch.\n\n"
			return true
		elsif result == 2
			return false
		else 
			puts "Please make the proper input"
			check = "repeat"
			result = gets.to_i
		end
	#end
	return
end

def two_goblins_defeated(monster, character, enemy_adjective, melee_body_part, luck)

	@luck = Random.new
	luck = @luck.rand(1..10)
	if (torch? && luck > 6) || (torch? && @stats[:intelligence] > 5) || (luck > 8) || (luck > 5 && @stats[:intelligence] > 6) || (@stats[:dexterity] > 8 && luck > 4)
		puts "As you continue down the tunnel, your keen eye notices, that the rocks ahead of you are different. You bend down to examine them and discover a pit trap. You carefully edge your way around it."
	else 
		puts "You continue down the tunnel. All of a sudden the ground gives way beneath your feet. You plummet down into a pit filled with fire hardened wooden stakes."
		@stats[:vitality] -= 5
		@stats[:dexterity] -= 3
		if death_check 
			puts "You gasp in agony, stakes impaling you all over your body. You can not even move, as you slowly slide down the stakes. The end comes slowly, to slowly."
			return death
		end
	end
	return "In two_goblins_defeated"

end

def merchant_goblins

end

def charmed_goblins

	return "In charmed_goblins"

end

def not_charmed_goblins

	puts "1) You take the goblins advice, and turn around and leave.\n\n2) You draw your sword and attack.\n\n"
	result = gets.to_i
	check = "repeat"
	while check == "repeat" do
		if result == 1
			return return_to_tavern
		elsif result == 2
			goblin_generator
			combat(@goblin, @stats, @enemy_adjective, @melee_body_part, @luck)
			puts "After dispatching the first goblin, you advance on the second goblin, he hesitates for  moment and then attacks!"
			goblin_generator
			combat(@goblin, @stats, @enemy_adjective, @melee_body_part, @luck)
			puts "You wipe the black blood from your blade and advance down the tunnel\n\n"
			return two_goblins_defeated
		else 
			puts "Please make the proper input"
			check = "repeat"
			result = gets.to_i
		end
	end

end

def rock_fall(monster, character, enemy_adjective, melee_body_part, luck)

	puts "The commotion of the falling rocks seems to have alerted some goblins. You hear high pitched, excited voices echoing up the tunnel.\n\n"
	puts "Stats reminder #{@stats}\n\n"
	puts "1) You draw your sword, bellowing your warcry and charge aound the corner to smite your enemies."
	puts "2) You look around to see if you can find a decent ambush point."
	puts "3) Yeesh, they sound pissed. It's time to scramble over those rocks and get out of here!"
	puts "4) There appears to be a little hollow in those fallen rocks, I'm going to try to squeeze in there and hide."
	
	result = gets.to_i
	puts ""

	check = "repeat"
	while check == "repeat" do
		if result == 1
			puts "There are two goblins charging towards you brandishing short swords's. The tunnel is narrow though, and they can only approach you one at a time."
			goblin_generator
			combat(@goblin, @stats, @enemy_adjective, @melee_body_part, @luck)
			puts "After dispatching the first goblin, you advance on the second goblin, he hesitates for  moment and then attacks!"
			goblin_generator
			combat(@goblin, @stats, @enemy_adjective, @melee_body_part, @luck)
			puts "You wipe the black blood from your blade and advance down the tunnel"
			return two_goblins_defeated(@goblin, @stats, @enemy_adjective, @melee_body_part, @luck)
		elsif result == 2
			@luck = Random.new
			luck = @luck.rand(1..10)
			ambush_prep = "You spy a perfect nook above the exit of the tunnel, and scramble up to it, drawing your throwing knives.\n\nAs the first goblin exits out of the tunnel, you hurl your dagger into it's head. It collapses in a thud. The second goblin spies you and leaps up to your position. #{@stats[:xp] += 10}"
			ambush_succesful = "You check the body of the first goblin you killed and find 2 gold pieces. #{@stats[:gold] += 2}You wipe the black blood from your blade and advance down the tunnel\n\n"
			if ((luck > 6) || (luck > 4 && @stats[:intelligence] > 5))
				puts ambush_prep
				goblin_generator
				combat(@goblin, @stats, @enemy_adjective, @melee_body_part, @luck)
				puts ambush_succesful
				return two_goblins_defeated(@goblin, @stats, @enemy_adjective, @melee_body_part, @luck)
			else
				puts "You look around, but can't find any good ambush points. A harsh goblin voice cries out. You turn to face them, moving into the tunnel so that you only have to face them one at a time."
				result = 1
			end
		elsif result == 3
			puts "You hightail it back to the tavern. You've had enough adventure for the day.\n\n"
			return return_to_tavern
		elsif result == 4
			puts = "You find a perfect little nook to crawl into. You scramble in and keep quiet.\n\n"
			success = "The goblins walk right over you. Muttering to each other in their harsh language. They survey the rock fall and proced farther down the tunnel back towards the entrance.\n\n"
			@luck = Random.new
			luck = @luck.rand(1..10)
			if (luck > 6 || (luck > 3 && @stats[:intelligence] > 4))
				puts success
				@stats[:xp] += 10
				return two_goblins_defeated(@goblin, @stats, @enemy_adjective, @melee_body_part, @luck)
			else
				puts "Alas, as the goblins make their way over the rock fall, their weight on the pile makes the whole pile shift. With great alarm you realize that your hiding spot is collapsing, but your wedged in to tightly to get out with the speed required. With a groan, the pile collapses on you, After minutes of aginizing pain, the rocks crush you, setteling on your chest and amking it impossible to breathe. You slowly suffocate.\n\n"
				return death
			end
		else 
			puts "Please make the proper input"
			check = "repeat"
			result = gets.to_i
		end
	end

end

def no_rock_fall(monster, character, enemy_adjective, melee_body_part, luck)

	puts "You go to the end of the tunnel and then peer around the corner. You see two goblins at the end of another tunnel. They are talking quietly to each other.\n\n1) Charge around the corner and attack them! It's a narrow tunnel, they will have to fight you one at a time.\n2) Get as close as you can and try to take one out before they see you.\n3) Beguile them with your charms.\n4) Pretend that you are a merchant seeking a lucrative trade with their village.\n\n"
	@luck = Random.new
	luck = @luck.rand(1..10)
	result = gets.to_i
	puts ""
	check = "repeat"
	while check == "repeat" do
		if result == 1
			puts "\nYou charge down the tunnel, sword drawn and attack!"
			goblin_generator
			combat(@goblin, @stats, @enemy_adjective, @melee_body_part, @luck)
			puts "After dispatching the first goblin, you advance on the second goblin, he hesitates for  moment and then attacks!"
			goblin_generator
			combat(@goblin, @stats, @enemy_adjective, @melee_body_part, @luck)
			puts "You wipe the black blood from your blade and advance down the tunnel\n\n"
			return two_goblins_defeated(@goblin, @stats, @enemy_adjective, @melee_body_part, @luck)
		elsif result == 2
			puts "You move quietly down the tunnel, ducking from shadow to shadow, making sure to only move when their backs are turned."
			success = "You slide quietly up behind the closest goblin and you stab it in the back. It gives a cry and drops to the floor. Te other goblin spins, snarls and raises her weapon."
			if ((luck > 3 && character[:dexterity] > 7) || (luck > 6 && character[:dexterity] > 5) || luck > 8) 
			 	puts success
			 	goblin_generator
				combat(@goblin, @stats, @enemy_adjective, @melee_body_part, @luck)
				puts "You wipe the black blood from your blade and advance down the tunnel\n\n"
				return two_goblins_defeated(@goblin, @stats, @enemy_adjective, @melee_body_part, @luck)
			else
				puts "As you slink down the tunnel, you scuff a bit loudly and the goblin guards spin. They raise their swords and charge!"
				goblin_generator
				combat(@goblin, @stats, @enemy_adjective, @melee_body_part, @luck)
				puts "After dispatching the first goblin, you advance on the second goblin, he hesitates for  moment and then attacks!"
				goblin_generator
				combat(@goblin, @stats, @enemy_adjective, @melee_body_part, @luck)
				puts "You wipe the black blood from your blade and advance down the tunnel\n\n"
				return two_goblins_defeated(@goblin, @stats, @enemy_adjective, @melee_body_part, @luck)
			end	
		elsif result == 3
			puts "You throw back your cloak, revealing your beautiful face, and strut down the tunnel. Calling out, \"It is I! #{@player_name}, you are truely lucky to be allowed in my presence, you little darlings. Come closer so that you may bask before me.\"\n\n"
				if (luck > 5 && @stats[:beauty] > 8)
					puts "The goblins, mouths drop in awe and they drop to their knees throwing their arms out before them in suplication. \"Lead us great one!\" they croak in broken human. \"What would you have us do?\"\n\n"
					return charmed_goblins(@goblin, @stats, @enemy_adjective, @melee_body_part, @luck)
				else
					puts "The goblins, stare at you and then break into fits of laughter. After a brief bout they declare in poorly spoken human, \"You are very funny human. We have not had such a laugh in many days. For that, we will not kill you. If you leave now, we will spare your miserable life.\" Then the mirth leaves their eyes to be replaced by hostility. \"Leave now, or you die! Humans are always killing us, and we will return the favor\"\n\n"
					 return not_charmed_goblins(@goblin, @stats, @enemy_adjective, @melee_body_part, @luck)
				end 
		elsif result == 4
			puts "You walk down the tunnel after relighting your torch and call out, \"You there! I am #{@player_name}, the gretest name this side of Earogoth! I come to make a lucrative trade with your chief. Take me to him!\"\n\n"	
			success = "The goblins, look at each other, and wisper back and forth between one another for a moment and then look at you cautiously. They say \"we shall do as you say, for now.\"\n\n"
				if ((luck > 4 && @stats[:intelligence] > 5 && @stats[:beauty] > 7) || (luck > 6 && @stats[:beauty] > 8) || luck > 8 )
					puts success
					return merchant_goblins(@goblin, @stats, @enemy_adjective, @melee_body_part, @luck)
				else
					puts "The goblins mutter quietly between themselves for a moment and then turn raise their swords and charge."
					result = 1
				end
		else 
			puts "Please make the proper input"
			check = "repeat"
			result = gets.to_i
		end
	end
end

def adventure(monster, character, enemy_adjective, melee_body_part, luck)

	puts "What is your name brave adventurer?\n\n"
	@player_name = gets.chomp
	puts "Are you prepared for a grand adventure #{@player_name}?\n\n"
	puts stat_generator

	result = 2
	while result == 2 
		puts "Here is your first game choice. Enter just the number to the left of the choice to make your selection.\n\nIf you would like to keep your character,\n\n1) Yes, I would like to keep my amazing stats!\n2) No, this character is the worst, make me a new one!\n\n"
		result = gets.to_i
		if result == 1
			puts "\nMay you find success!\n\n"
		elsif result == 2
			puts stat_generator
		else
			puts "Please make the proper input\n\n"
			result = 2
		end
	end

	puts "You've heard that there is a cave nearby filled with weak little gobins who have been terrorizing the local peasants who are even weaker and punier. Sadly, you lost a lot of coin playing Diamondback the other night and you really need to refill your personal cofers, and you're still pissed about your loss, so nothing quite like doing some ultra-violence on some puny goblins to make you feel better about your self.\n\nAs you approach the entrance to the dank cave, a cold, foul wind wafts out. A chill goes through your bones and a sense of grand foreboding fills your soul.\n\n1) This is a direct sign from the all mighty Thormidal!! It is a sign that I should return to the village and renounce my sinfull ways!\n2) Hmmm, this sense of forebodeing makes me nervous, I shall enter as silently as I can...\n3) Paaah, this is naught but foolishness, I shall let forth a great war cry so all may know my rath. #{@player_name} fears nothing!!!"
	
	result = gets.to_i
	check = "repeat"

	while check == "repeat"		
		if result == 1
			puts "You return to the village, feeling a little foolish. What made you filled with such bloodthristy greed in the first place? Perhaps it was the curse of Udenas. Well, at least the spell has passed by and the peace of Thormidal has filled you once again.  Some meditation in the gardens of peace is needed."
			return death
				
		elsif result == 2
			puts "You sneak quietly into the gloom of the cave.\n\n"
			if @stats[:dexterity] > 5
				puts "You see a goblin skulking in the gloom ahead with a bow and arrow, watching the entrance carefully. Good thing you came in quietly! You sneak up behind it and stab it in the back. It gives a gasp and falls over dead. You feel through its pockets and find 1 gold piece and an iron key.\n\n"
				@stats[:gold] += 1
				@stats[:xp] += 10
				@stats[:inventory] << "iron key"
				break
			elsif @stats[:dexterity] > 2
				puts "As you try to sneak into the gloomy cave, you step on a stick. It snaps and the goblin spins and takes a shot at you while hollering an alarm.\n\n"
					@luck = Random.new
					luck = @luck.rand(1..10)
					if luck > 5
						@stats[:gold] += 1
						@stats[:xp] += 10
						@stats[:inventory] << "iron key"
						puts "The arrow wizzes over your head. As the goblin grabs another arrow, he fumbles it in his fear, giving you time enough to thrust your knife into its belly.  He gives a cry and blood gurgles up between his lips as he dies. You feel through its pockets and find 1 gold piece and an iron key.\n\n"
						break	
					else 
						puts "The arrow thunks into your thigh and a searing pain shoots through your body.\n\n"
						@stats[:vitality] -= 2
						@stats[:dexterity] -= 1
						if death_check 
							puts "You colapse to the ground holding your leg. The goblin walks over, knife in hand and a leer on its face. He laughs as he opens your throat and you feel no more ..."
							return death
						else
						@stats[:gold] += 1
						@stats[:xp] += 10
						@stats[:inventory] << "iron key"
						puts "You reach into your belt and grab a knife, hurtling into the goblins eye. It's hand fly to its face and then it collapses in death. You feel through its pockets and find 1 gold piece and an iron key.\n\n"
						break
						end
					end
			else
			puts "You trip on a gnarled root as you clumsily feel your way into the darkness. You fall head long into a pit, impaling yourself on a staligmite."
			return death
			end

		elsif result == 3
			@luck = Random.new
			luck = @luck.rand(1..10)
			puts "With a roar you plunge headlong into the darkness, you hear the scretches of goblins in front of you. Prepare for battle!\n\n"
			if (@stats[:dexterity] > 6 && @stats[:strength] > 5) || (luck > 3)
				@stats[:gold] += 1
				@stats[:xp] += 10
				@stats[:inventory] << "iron key"
				puts "You see a goblin in the gloom readying bow and arrow. You run up to him and ram your sword into his throat. Afer looting his body you find a gold piece and an iron key.\n\n"
				break
			elsif luck > 0
				@stats[:dexterity] -= 1
				@stats[:vitality] -= 2
				puts "An arrow thunks into your thigh and a searing pain shoots through your body.\n\n" 
					if death_check
						puts "You colapse to the ground holding your leg. A goblin walks over, knife in hand and a leer on its face. He laughs as he opens your throat and you feel no more ..."
						return death
					else
					@stats[:gold] += 1
					@stats[:xp] += 10
					@stats[:inventory] << "iron key"
					puts "You spy the archer, a goblin, high in the cave. He's readying another shot. You reach into your belt and grab a knife, hurtling into the goblins eye. It's hand fly to its face and then it collapses in death. You climb up to it and feel through its pockets finding 1 gold piece and an iron key.\n\n"
					break
					end
			end

		else
			check = "repeat"
			puts "Please enter a correct response."
			result = gets.to_i
		end
	end

	puts "Stats reminder: #{@stats}\n\nYou survey the cave and see a tunnel leading down.\n\n1) I've had enough of this. I'm going back to the tavern. I can get back in on a game of Diamondback and win all my money back with 1 gold piece.\n2) Head down the tunnel.\n\n"
	result = gets.to_i
	check = "repeat"
	while check == "repeat" do
		if result == 1
			return return_to_tavern
		elsif result == 2
			puts "You travel down into the dark tunnel. At least you have a torch."
			break
		else 
			puts "Please make the proper input"
			check = "repeat"
			result = gets.to_i
		end
	end

	puts "It's very hard to see in this dark tunnel. Would you like to light your torch?\n\n1) You light the torch.\n2) You walk carefully into the dim tunnel, felling carefully with your hand.\n\n"
	result = gets.to_i
	check = "repeat"
	while check == "repeat" do
		success = "As you approch the end of the tunnel, you hear sounds ahead. You snub out your torch, wait for your eyes to readjust.\n\n"
		if result == 1
			puts "Your torch flares to light.\n\n"
			
			@luck = Random.new
			luck = @luck.rand(1..10)
			if luck > 3 && @stats[:intelligence] > 6
				@stats[:xp] += 5
				puts "You notice a rock trap in the ceiling, a tripwire connected to rocks in the ceiling.You gingerly step over the string and continue down the tunnel.\n\n"
				puts success
				return no_rock_fall(@goblin, @stats, @enemy_adjective, @melee_body_part, @luck)
			elsif luck > 7
				@stats[:xp] += 5
				puts "You notice a rock trap in the ceiling, a tripwire connected to rocks in the ceiling.You gingerly step over the string and continue down the tunnel.\n\n"
				puts success
				return no_rock_fall(@goblin, @stats, @enemy_adjective, @melee_body_part, @luck)
			elsif @stats[:dexterity] > 7
				@stats[:xp] += 5
				puts "As you walk down the tunnel, you trip on a rope and you hear a a stick snap above you. A trap! You dive forward and tuck in to a roll. Rocks crash behind you, leaving you covered in a layer of dust, but otherwise unharmed.\n\n"
				return rock_fall(@goblin, @stats, @enemy_adjective, @melee_body_part, @luck)
			else
				@stats[:vitality] -= 2
				if death_check
					puts "As you walk down the tunnel, you trip on a rope and you hear a a stick snap above you. A trap! Rocks tumble down upon you in a thunderous roar. You try to run, but a large rock caves in your head.\n\n"
					return death
				else
					puts "As you walk down the tunnel, you trip on a rope and you hear a a stick snap above you. A trap! The rocks crash over you, battering you mercilessly, but you manage to cover your head and sholder through. Ouuch\n\n"
					return rock_fall(@goblin, @stats, @enemy_adjective, @melee_body_part, @luck)
				end
			@stats[:xp] += 5
			puts "As you walk down the tunnel, you trip on a rope and you hear a a stick snap above you. A trap! You dive forward and tuck in to a roll. Rocks crash behind you, leaving you covered in a layer of dust, but otherwise unharmed.\n\n"
			return rock_fall(@goblin, @stats, @enemy_adjective, @melee_body_part, @luck)
			end

		elsif result == 2
			puts "You feel your way into the tunnel. You can dimly make out the way.\n\n"
			@luck = Random.new
			luck = @luck.rand(1..10)
			if (luck > 6 && @stats[:intelligence] > 6)
				@stats[:xp] += 5
				puts "You notice a rock trap in the ceiling, a tripwire connected to rocks in the ceiling.You gingerly step over the string and continue down the tunnel.\n\n"
				return no_rock_fall(@goblin, @stats, @enemy_adjective, @melee_body_part, @luck)
			elsif @stats[:dexterity] > 7
				@stats[:xp] += 5
				puts "As you walk down the tunnel, you trip on a rope and you hear a a stick snap above you. A trap! You dive forward and tuck in to a roll. Rocks crash behind you, leaving you covered in a layer of dust, but otherwise unharmed.\n\n"
				return rock_fall(@goblin, @stats, @enemy_adjective, @melee_body_part, @luck)
			else
				@stats[:vitality] -= 2
				if death_check
					puts "As you walk down the tunnel, you trip on a rope and you hear a a stick snap above you. A trap! Rocks tumble down upon you in a thunderous roar. You try to run, but a large rock caves in your head.\n\n"
					return death
				else
					puts "The rocks crash over you, battering you mercilessly, but you manage to cover your head and sholder through. Ouuch\n\n"
					return rock_fall(@goblin, @stats, @enemy_adjective, @melee_body_part, @luck)
				end
			@stats[:xp] += 5
			puts "As you walk down the tunnel, you trip on a rope and you hear a a stick snap above you. A trap! You dive forward and tuck in to a roll. Rocks crash behind you, leaving you covered in a layer of dust, but otherwise unharmed.\n\n"
			return rock_fall(@goblin, @stats, @enemy_adjective, @melee_body_part, @luck)
			end
			
		else 
			puts "Please make the proper input"
			check = "repeat"
			result = gets.to_i
		end
	end

end

puts adventure(@goblin, @stats, @enemy_adjective, @melee_body_part, @luck)



#death check? inquire if user wants to play a new game sequence	
# if death_check 
# 	puts Specific Death Sequence
# 	return death
# end
# 

# @luck check
# @luck = Random.new
# luck = @luck.rand(1..10)
# if luck > 5

#general structure of choices
#result = gets.to_i
#check = "repeat"
# while check == "repeat" do
# 	if result == 1
# 		puts "It's a one"
# 	elsif result == 2
# 		puts "It's a 2"
# 	elsif result == 3
# 		puts "It's a three"
# 	else 
# 		puts "Please make the proper input"
# 		check = "repeat"
# 		result = gets.to_i
# 	end
# end

