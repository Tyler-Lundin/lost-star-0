extends Camera3D

# Camera movement settings
@export var move_speed: float = 10.0
@export var rotation_speed: float = 2.0
@export var zoom_speed: float = 2.0
@export var min_zoom: float = 5.0
@export var max_zoom: float = 20.0

# Camera state
var target_position: Vector3
var target_rotation: Vector3
var current_zoom: float = 10.0

func _ready() -> void:
    # Set initial camera position and rotation for isometric view
    position = Vector3(10, 10, 10)
    rotation = Vector3(-PI/4, PI/4, 0)
    target_position = position
    target_rotation = rotation
    
    # Set initial zoom
    current_zoom = 10.0
    update_zoom()

func _process(delta: float) -> void:
    # Handle keyboard input for camera movement
    var input_dir = Vector3.ZERO
    if Input.is_action_pressed("camera_right"):
        input_dir.x += 1
    if Input.is_action_pressed("camera_left"):
        input_dir.x -= 1
    if Input.is_action_pressed("camera_forward"):
        input_dir.z -= 1
    if Input.is_action_pressed("camera_backward"):
        input_dir.z += 1
    
    # Apply movement
    if input_dir != Vector3.ZERO:
        input_dir = input_dir.normalized()
        target_position += input_dir * move_speed * delta
    
    # Smooth camera movement
    position = position.lerp(target_position, delta * 5.0)
    
    # Handle zoom
    if Input.is_action_just_released("camera_zoom_in"):
        current_zoom = max(current_zoom - zoom_speed, min_zoom)
        update_zoom()
    elif Input.is_action_just_released("camera_zoom_out"):
        current_zoom = min(current_zoom + zoom_speed, max_zoom)
        update_zoom()

func update_zoom() -> void:
    # Update camera position based on zoom level while maintaining isometric angle
    var zoom_offset = Vector3(current_zoom, current_zoom, current_zoom)
    target_position = Vector3(10, 10, 10) + zoom_offset

func _input(event: InputEvent) -> void:
    # Handle mouse wheel zoom
    if event is InputEventMouseButton:
        if event.button_index == MOUSE_BUTTON_WHEEL_UP:
            current_zoom = max(current_zoom - zoom_speed, min_zoom)
            update_zoom()
        elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
            current_zoom = min(current_zoom + zoom_speed, max_zoom)
            update_zoom() 