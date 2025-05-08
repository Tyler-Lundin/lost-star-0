extends Node

const AGES = {
	"stone_age": {
		"name": "Stone Age",
		"description": "The beginning of civilization",
		"unlock_requirements": {},
		"resource_multipliers": {
			"food": 1.0,
			"wood": 1.0,
			"stone": 1.0,
			"gold": 0.0,
			"science": 0.0,
			"mana": 0.0,
			"data": 0.0
		},
		"available_buildings": ["hut", "farm", "woodcutter", "quarry"],
		"available_units": ["villager", "hunter", "gatherer"]
	},
	"bronze_age": {
		"name": "Bronze Age",
		"description": "The age of metal and writing",
		"unlock_requirements": {
			"science": 100,
			"stone": 500
		},
		"resource_multipliers": {
			"food": 1.5,
			"wood": 1.5,
			"stone": 1.5,
			"gold": 1.0,
			"science": 1.0,
			"mana": 0.0,
			"data": 0.0
		},
		"available_buildings": ["house", "farm", "woodcutter", "quarry", "mine", "library"],
		"available_units": ["villager", "hunter", "gatherer", "miner", "scholar"]
	},
	"iron_age": {
		"name": "Iron Age",
		"description": "The age of iron and empires",
		"unlock_requirements": {
			"science": 500,
			"gold": 1000
		},
		"resource_multipliers": {
			"food": 2.0,
			"wood": 2.0,
			"stone": 2.0,
			"gold": 1.5,
			"science": 1.5,
			"mana": 0.0,
			"data": 0.0
		},
		"available_buildings": ["house", "farm", "woodcutter", "quarry", "mine", "library", "barracks", "market"],
		"available_units": ["villager", "hunter", "gatherer", "miner", "scholar", "soldier", "merchant"]
	}
} 