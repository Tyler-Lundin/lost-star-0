extends Node

# Time-related constants
const SECONDS_PER_YEAR: float = 60.0  # 1 real second = 1 game year
const YEARS_PER_AGE: int = 100

# Current game time
var current_year: int = 0
var current_age: String = "Stone Age"
var time_scale: float = 1.0
var is_paused: bool = false

# Age progression data
var age_progression: Dictionary = {
    "Stone Age": {
        "next_age": "Bronze Age",
        "years_required": YEARS_PER_AGE,
        "requirements": {
            "food": 1000,
            "wood": 500,
            "stone": 250
        }
    },
    "Bronze Age": {
        "next_age": "Iron Age",
        "years_required": YEARS_PER_AGE,
        "requirements": {
            "food": 2000,
            "wood": 1000,
            "stone": 500,
            "bronze": 100
        }
    }
    # More ages will be added as the game progresses
}

func _ready() -> void:
    # Connect to EventBus signals
    EventBus.game_paused.connect(_on_game_paused)
    EventBus.game_resumed.connect(_on_game_resumed)
    
    EventBus.debug("TimeManager initialized", "info")

func _process(delta: float) -> void:
    if is_paused:
        return
        
    # Update game time
    var time_delta = delta * time_scale
    current_year += int(time_delta * SECONDS_PER_YEAR)
    
    # Emit time advanced signal
    EventBus.time_advanced.emit(time_delta)
    
    # Check for age progression
    _check_age_progression()

func _check_age_progression() -> void:
    var current_age_data = age_progression[current_age]
    if current_year >= current_age_data.years_required:
        # Check if requirements are met
        if _check_age_requirements(current_age_data.requirements):
            _advance_age(current_age_data.next_age)

func _check_age_requirements(requirements: Dictionary) -> bool:
    for resource_type in requirements:
        var required_amount = requirements[resource_type]
        var current_amount = ResourceManager.get_resource(resource_type).amount
        if current_amount < required_amount:
            return false
    return true

func _advance_age(new_age: String) -> void:
    if not age_progression.has(new_age):
        EventBus.debug("Invalid age: " + new_age, "error")
        return
        
    current_age = new_age
    EventBus.age_changed.emit(new_age)
    EventBus.debug("Advanced to " + new_age, "info")

func set_time_scale(scale: float) -> void:
    time_scale = max(0.0, scale)  # Ensure non-negative
    EventBus.debug("Time scale set to " + str(time_scale), "info")

func _on_game_paused() -> void:
    is_paused = true

func _on_game_resumed() -> void:
    is_paused = false

# Save/Load functions
func get_save_data() -> Dictionary:
    return {
        "current_year": current_year,
        "current_age": current_age,
        "time_scale": time_scale,
        "is_paused": is_paused
    }

func load_save_data(data: Dictionary) -> void:
    current_year = data.current_year
    current_age = data.current_age
    time_scale = data.time_scale
    is_paused = data.is_paused
    
    EventBus.age_changed.emit(current_age)
    EventBus.debug("Time data loaded", "info")
