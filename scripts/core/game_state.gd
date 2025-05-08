extends Node

# GameState singleton to manage the overall game state
# Signals
signal game_loaded
signal game_saved
signal resource_changed(resource_type: String, amount: float)
signal time_advanced(delta: float)
signal age_changed(new_age: String)
signal building_constructed(building_id: String)
signal unit_created(unit_id: String)
signal task_completed(task_id: String)

## === META DATA === ##
var current_age: String = "stone_age"
var age_index: int = 0
var total_play_time: float = 0.0
var is_widget_mode: bool = false
var last_save_time: int = 0  # Unix timestamp
var is_paused: bool = false

## === CITY STATE === ##
var resources := {
	"food": 0,
	"wood": 0,
	"stone": 0,
	"gold": 0,
	"science": 0,
	"mana": 0,
	"data": 0
}

var resource_rates := {
	"food": 0.0,
	"wood": 0.0,
	"stone": 0.0,
	"gold": 0.0,
	"science": 0.0,
	"mana": 0.0,
	"data": 0.0
}

var buildings := {}  # key = building_id, value = BuildingData
var units := {}      # key = unit_id, value = UnitData

## === ACTIVE TASKS === ##
var tasks: Array = []  # List of TaskData

## === MAP DATA === ##
var map_tiles := {}  # Dictionary<Vector2, TileData>

## === TIMELINE / AGES === ##
var unlocked_ages := ["stone_age"]
var age_definitions := preload("res://data/ages.gd").AGES  # external resource for static data

func _ready() -> void:
	# Initialize game state
	_initialize_resources()

func _process(delta: float) -> void:
	if not is_paused:
		total_play_time += delta
		time_advanced.emit(delta)
		_process_resources(delta)

func _initialize_resources() -> void:
	# Set initial resource rates based on starting age
	var age_data = get_current_age_data()
	for resource in resources:
		resource_rates[resource] = age_data.resource_multipliers.get(resource, 0.0)

func _process_resources(delta: float) -> void:
	# Process resource generation
	for resource in resources:
		var amount = resource_rates[resource] * delta
		if amount > 0:
			add_resource(resource, amount)
			resource_changed.emit(resource, resources[resource])

## === RESOURCE MANAGEMENT === ##
func get_resource(name: String) -> int:
	return resources.get(name, 0)

func add_resource(name: String, amount: float) -> void:
	resources[name] = get_resource(name) + amount
	resource_changed.emit(name, resources[name])

func set_resource_rate(name: String, rate: float) -> void:
	resource_rates[name] = rate

## === AGE MANAGEMENT === ##
func get_current_age_data() -> Dictionary:
	return age_definitions.get(current_age, {})

func progress_to_next_age() -> bool:
	if age_index + 1 < age_definitions.keys().size():
		age_index += 1
		current_age = age_definitions.keys()[age_index]
		unlocked_ages.append(current_age)
		
		# Update resource rates for new age
		var age_data = get_current_age_data()
		for resource in resources:
			resource_rates[resource] = age_data.resource_multipliers.get(resource, 0.0)
		
		age_changed.emit(current_age)
		return true
	return false

## === BUILDING MANAGEMENT === ##
func construct_building(building_id: String, position: Vector2) -> bool:
	if not buildings.has(building_id):
		buildings[building_id] = {
			"id": building_id,
			"position": position,
			"construction_progress": 0.0
		}
		building_constructed.emit(building_id)
		return true
	return false

## === UNIT MANAGEMENT === ##
func create_unit(unit_id: String, position: Vector2) -> bool:
	if not units.has(unit_id):
		units[unit_id] = {
			"id": unit_id,
			"position": position,
			"health": 100.0,
			"state": "idle"
		}
		unit_created.emit(unit_id)
		return true
	return false

## === TASK MANAGEMENT === ##
func add_task(task_data: Dictionary) -> void:
	tasks.append(task_data)

func complete_task(task_id: String) -> void:
	for i in range(tasks.size()):
		if tasks[i].id == task_id:
			tasks.remove_at(i)
			task_completed.emit(task_id)
			break

## === GAME STATE MANAGEMENT === ##
func set_paused(paused: bool) -> void:
	is_paused = paused

func get_game_time() -> float:
	return total_play_time

func get_current_age() -> String:
	return current_age

func set_current_age(age: String) -> void:
	current_age = age 