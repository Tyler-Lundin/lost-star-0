extends Camera3D

# Camera settings
@export var min_zoom: float = 5.0
@export var max_zoom: float = 20.0
@export var zoom_speed: float = 2.0
@export var rotation_speed: float = 1.0
@export var tilt_angle: float = 45.0  # Default 45-degree angle for 2.5D view

var current_zoom: float = 10.0
var current_rotation: float = 0.0

func _ready() -> void:
	# Set initial camera position and rotation
	position = Vector3(0, current_zoom, current_zoom)
	rotation_degrees = Vector3(-tilt_angle, 0, 0)
	look_at(Vector3.ZERO)

func _input(event: InputEvent) -> void:
	# Handle zoom with mouse wheel
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			current_zoom = clamp(current_zoom - zoom_speed, min_zoom, max_zoom)
			_update_camera_position()
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			current_zoom = clamp(current_zoom + zoom_speed, min_zoom, max_zoom)
			_update_camera_position()
	
	# Handle rotation with right mouse button
	elif event is InputEventMouseMotion:
		if event.button_mask == MOUSE_BUTTON_RIGHT:
			current_rotation -= event.relative.x * rotation_speed * 0.01
			_update_camera_position()

func _update_camera_position() -> void:
	# Calculate new position based on zoom and rotation
	var angle = deg_to_rad(current_rotation)
	position.x = sin(angle) * current_zoom
	position.z = cos(angle) * current_zoom
	position.y = current_zoom
	
	# Keep camera looking at center
	look_at(Vector3.ZERO)
	# Maintain tilt angle
	rotation_degrees.x = -tilt_angle 