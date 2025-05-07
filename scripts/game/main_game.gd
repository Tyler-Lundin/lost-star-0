extends Node

@onready var time_info = $UI/VBoxContainer/TimeInfo
@onready var resource_list = $UI/VBoxContainer/ResourceList
@onready var start_button = $UI/VBoxContainer/Controls/StartButton
@onready var pause_button = $UI/VBoxContainer/Controls/PauseButton
@onready var resume_button = $UI/VBoxContainer/Controls/ResumeButton
@onready var speed1x_button = $UI/VBoxContainer/SpeedControls/Speed1xButton
@onready var speed2x_button = $UI/VBoxContainer/SpeedControls/Speed2xButton
@onready var speed3x_button = $UI/VBoxContainer/SpeedControls/Speed3xButton
@onready var debug_timer = $UI/VBoxContainer/DebugTimer

var real_time_elapsed: float = 0.0

func _ready() -> void:
    # Connect button signals
    start_button.pressed.connect(_on_start_pressed)
    pause_button.pressed.connect(_on_pause_pressed)
    resume_button.pressed.connect(_on_resume_pressed)
    speed1x_button.pressed.connect(_on_speed_1x_pressed)
    speed2x_button.pressed.connect(_on_speed_2x_pressed)
    speed3x_button.pressed.connect(_on_speed_3x_pressed)
    
    # Connect EventBus signals
    EventBus.time_advanced.connect(_on_time_advanced)
    EventBus.age_changed.connect(_on_age_changed)
    EventBus.resource_changed.connect(_on_resource_changed)
    EventBus.game_started.connect(_on_game_started)
    EventBus.game_paused.connect(_on_game_paused)
    EventBus.game_resumed.connect(_on_game_resumed)
    
    # Initialize UI state
    _update_ui_state()
    _create_resource_labels()
    _update_speed_buttons()

func _create_resource_labels() -> void:
    # Clear existing labels
    for child in resource_list.get_children():
        child.queue_free()
    
    # Create labels for each resource
    for resource_type in ResourceManager.resources:
        var label = Label.new()
        label.text = "%s: 0" % resource_type
        label.name = resource_type + "Label"
        resource_list.add_child(label)

func _update_ui_state() -> void:
    var is_started = GameManager.is_game_started
    var is_paused = GameManager.is_game_paused
    
    start_button.disabled = is_started
    pause_button.disabled = not is_started or is_paused
    resume_button.disabled = not is_started or not is_paused
    
    # Update speed buttons state
    speed1x_button.disabled = not is_started or is_paused
    speed2x_button.disabled = not is_started or is_paused
    speed3x_button.disabled = not is_started or is_paused

func _update_speed_buttons() -> void:
    var current_speed = TimeManager.time_scale
    speed1x_button.button_pressed = current_speed == 1.0
    speed2x_button.button_pressed = current_speed == 2.0
    speed3x_button.button_pressed = current_speed == 3.0

func _on_start_pressed() -> void:
    GameManager.start_game()

func _on_pause_pressed() -> void:
    GameManager.pause_game()

func _on_resume_pressed() -> void:
    GameManager.resume_game()

func _on_speed_1x_pressed() -> void:
    TimeManager.set_time_scale(1.0)
    _update_speed_buttons()

func _on_speed_2x_pressed() -> void:
    TimeManager.set_time_scale(2.0)
    _update_speed_buttons()

func _on_speed_3x_pressed() -> void:
    TimeManager.set_time_scale(3.0)
    _update_speed_buttons()

func _on_time_advanced(delta: float) -> void:
    time_info.text = "Year: %d | Age: %s" % [TimeManager.current_year, TimeManager.current_age]

func _on_age_changed(new_age: String) -> void:
    time_info.text = "Year: %d | Age: %s" % [TimeManager.current_year, new_age]

func _on_resource_changed(resource_type: String, amount: float) -> void:
    var label = resource_list.get_node_or_null(resource_type + "Label")
    if label:
        label.text = "%s: %.1f" % [resource_type, amount]

func _on_game_started() -> void:
    real_time_elapsed = 0.0  # Reset timer when game starts
    _update_ui_state()

func _on_game_paused() -> void:
    _update_ui_state()

func _on_game_resumed() -> void:
    _update_ui_state()

func _process(delta: float) -> void:
    if GameManager.is_game_started and not GameManager.is_game_paused:
        real_time_elapsed += delta
        debug_timer.text = "Real Time: %.1fs" % real_time_elapsed 