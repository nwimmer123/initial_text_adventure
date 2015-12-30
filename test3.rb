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

	puts @goblin