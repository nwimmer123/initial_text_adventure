# Text Adventure RPG
## Old School Text Game

## Synopsis

The purpose of this game is to practice using Ruby and to have a fun text adventure game to play. The story follows the adventure of a "hero" who is broke and decides to try their luck plundering a nearby cave complex. However, their confidence may be a bit overblown.

## Concept and Code Snippets

This whole project is one file, written in Ruby, so the user interacts with it in the console.

The first thing the user does is generate a character. They will be presented with a lot of choices. Their success will be determined by a bit of luck and wether they have determined enough of the prerequisite skill to succeed. However, these game mechanics are hidden form the user, so they do not know what skill is required or what stat number is required to be successful. However, they are mostly common sense. For example, moving carefully will require dexterity, the more challenging, the higher the number.

Here is an example of a choice

```
if luck > 3 && @stats[:intelligence] > 6
	@stats[:xp] += 5
	puts "You notice a rock trap in the ceiling, a tripwire connected to rocks in the ceiling.You gingerly step over the string and continue down the tunnel.\n\n"
	puts success
	return no_rock_fall(@goblin, @stats, @enemy_adjective, @melee_body_part, @luck)
```

My favorite aspect of the game though is the use of a luck array. All actions also involve a degree of luck. With extreme poor luck leading to damage or death. This is my generic luck generator.

```
#This is at the top, outside of the functions

@luck = [1,2,3,4,5,6,7,8,9,10]

#The following is in all the functions that require a luck check

@luck = Random.new
luck = @luck.rand(1..10)

```

I was particularly proud of my combat loop that may cycle through 10 different functions: combat, attack, parry, run away, monster death?, monster death, death, death check, level up check, and level up.

For the story sequence I created functions for chunks of the story. At a new branch a result returns the user into a new function holding the next set of steps.

## Challenges

* Getting the combat loop to work
* Devising a validation system that made sure that the user entered the correct input
* Keeping track of the game logic as it grows in length
* Debugging as future choices become dependent on prior actions, so it can be hard to find bugs and test things as created.

## Improvements

* The story structure should be simplified, if possible, maybe into an object system. However I need to work out how I would call functions from inside of these objects, and I've all ready gone so far using my current method, it seems like a real challenge to refactor it all. However I could just switch the story structure over to the object style in future story arcs and leave the code as is for whats all ready done.
* A lot of the could is repetitive. I should refactor it. I could convert some if elsif statements into or's in the if line, but I'm not sure that would be cleaner.