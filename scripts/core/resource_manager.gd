extends Node

# Resource data structure
class GameResource:
	var type: String
	var amount: float
	var capacity: float
	var production_rate: float
	var consumption_rate: float
	
	func _init(resource_type: String, initial_amount: float = 0.0, initial_capacity: float = 100.0) -> void:
		type = resource_type
		amount = initial_amount
		capacity = initial_capacity
		production_rate = 0.0
		consumption_rate = 0.0

# Dictionary to store all resources
var resources: Dictionary = {}

func _ready() -> void:
	# Connect to EventBus signals
	EventBus.time_advanced.connect(_on_time_advanced)
	EventBus.age_changed.connect(_on_age_changed)
	
	# Initialize basic resources
	_initialize_resources()

func _initialize_resources() -> void:
	# Add basic resources
	add_resource("food", 100.0, 1000.0)
	add_resource("wood", 50.0, 500.0)
	add_resource("stone", 25.0, 250.0)
	
	EventBus.debug("Resources initialized", "info")

func add_resource(type: String, initial_amount: float = 0.0, initial_capacity: float = 100.0) -> void:
	if resources.has(type):
		EventBus.debug("Resource type already exists: " + type, "warning")
		return
		
	resources[type] = GameResource.new(type, initial_amount, initial_capacity)
	EventBus.resource_changed.emit(type, initial_amount)
	EventBus.resource_capacity_changed.emit(type, initial_capacity)
	EventBus.debug("Resource added: " + type, "info")

func get_resource(type: String) -> GameResource:
	if not resources.has(type):
		EventBus.debug("Resource type not found: " + type, "error")
		return null
	return resources[type]

func modify_resource(type: String, amount: float) -> bool:
	if not resources.has(type):
		EventBus.debug("Resource type not found: " + type, "error")
		return false
		
	var resource = resources[type]
	var new_amount = resource.amount + amount
	
	# Check capacity
	if new_amount > resource.capacity:
		new_amount = resource.capacity
	elif new_amount < 0:
		new_amount = 0
		
	resource.amount = new_amount
	EventBus.resource_changed.emit(type, new_amount)
	return true

func set_resource_capacity(type: String, capacity: float) -> bool:
	if not resources.has(type):
		EventBus.debug("Resource type not found: " + type, "error")
		return false
		
	var resource = resources[type]
	resource.capacity = capacity
	EventBus.resource_capacity_changed.emit(type, capacity)
	return true

func set_production_rate(type: String, rate: float) -> bool:
	if not resources.has(type):
		EventBus.debug("Resource type not found: " + type, "error")
		return false
		
	var resource = resources[type]
	resource.production_rate = rate
	return true

func set_consumption_rate(type: String, rate: float) -> bool:
	if not resources.has(type):
		EventBus.debug("Resource type not found: " + type, "error")
		return false
		
	var resource = resources[type]
	resource.consumption_rate = rate
	return true

func _on_time_advanced(delta: float) -> void:
	# Update resources based on production and consumption rates
	for resource in resources.values():
		var net_change = (resource.production_rate - resource.consumption_rate) * delta
		modify_resource(resource.type, net_change)

func _on_age_changed(new_age: String) -> void:
	# Handle age-specific resource changes
	pass

# Save/Load functions
func get_save_data() -> Dictionary:
	var save_data = {}
	for type in resources:
		var resource = resources[type]
		save_data[type] = {
			"amount": resource.amount,
			"capacity": resource.capacity,
			"production_rate": resource.production_rate,
			"consumption_rate": resource.consumption_rate
		}
	return save_data

func load_save_data(data: Dictionary) -> void:
	for type in data:
		if not resources.has(type):
			add_resource(type)
		var resource = resources[type]
		var resource_data = data[type]
		resource.amount = resource_data.amount
		resource.capacity = resource_data.capacity
		resource.production_rate = resource_data.production_rate
		resource.consumption_rate = resource_data.consumption_rate
		EventBus.resource_changed.emit(type, resource.amount)
		EventBus.resource_capacity_changed.emit(type, resource.capacity)
