extends Node

var resources: Dictionary = {
    "Food": 0.0,
    "Wood": 0.0,
    "Stone": 0.0,
    "Gold": 0.0
}

func add_resource(resource_type: String, amount: float) -> void:
    if resources.has(resource_type):
        resources[resource_type] += amount
        EventBus.resource_changed.emit(resource_type, resources[resource_type]) 