extends Node

@onready var time_info = $UI/VBoxContainer/TimeInfo
@onready var resource_list = $UI/VBoxContainer/ResourceList
@onready var start_button = $UI/VBoxContainer/Controls/StartButton
@onready var pause_button = $UI/VBoxContainer/Controls/PauseButton
@onready var resume_button = $UI/VBoxContainer/Controls/ResumeButton
@onready var time_scale = $UI/VBoxContainer/TimeScale
@onready var time_scale_label = $UI/VBoxContainer/TimeScaleLabel

func _ready() -> void:
    # Connect button signals
    start_button.pressed.connect(_on_start_pressed)
    pause_button.pressed.connect(_on_pause_pressed)
    resume_button.pressed.connect(_on_resume_pressed)
    time_scale.value_changed.connect(_on_time_scale_changed)
    
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
    time_scale.editable = is_started and not is_paused

func _on_start_pressed() -> void:
    GameManager.start_game()

func _on_pause_pressed() -> void:
    GameManager.pause_game()

func _on_resume_pressed() -> void:
    GameManager.resume_game()

func _on_time_scale_changed(value: float) -> void:
    TimeManager.set_time_scale(value)
    time_scale_label.text = "Time Scale: %.1fx" % value

func _on_time_advanced(delta: float) -> void:
    time_info.text = "Year: %d | Age: %s" % [TimeManager.current_year, TimeManager.current_age]

func _on_age_changed(new_age: String) -> void:
    time_info.text = "Year: %d | Age: %s" % [TimeManager.current_year, new_age]

func _on_resource_changed(resource_type: String, amount: float) -> void:
    var label = resource_list.get_node_or_null(resource_type + "Label")
    if label:
        label.text = "%s: %.1f" % [resource_type, amount]

func _on_game_started() -> void:
    _update_ui_state()

func _on_game_paused() -> void:
    _update_ui_state()

func _on_game_resumed() -> void:
    _update_ui_state() 