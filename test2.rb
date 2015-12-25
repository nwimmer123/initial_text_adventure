stat = Random.new

goblin = {
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

def combat(monster, character)
	puts "player #{$stats}"
	puts "golin #{monster}"
	puts "The #{monster[:name]} attacks! Swinging it's #{monster[:weapon]}!"
	puts ""
	luck = [1,2,3,4,5,6,7,8,9,10]
	luck = Random.new
	luck = luck.rand(1..10)
	puts "player luck #{luck}"
	if (monster[:dexterity] > character[:dexterity] && luck <15)
		puts "The #{monster[:name]}'s #{monster[:weapon]} slips past your defense, slashing against your side."
		puts ""
		character[:vitality] = character[:vitality] - monster[:strength]
		puts $stats

	end

end

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
	level: 1,
	inventory: []
	}

	#puts $stats
	
end

puts stat_generator

puts combat(goblin, $stats)


