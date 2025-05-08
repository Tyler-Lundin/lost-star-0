extends Node

# CSS-like class system for Godot UI

# Button styles
static func primary_button(button: Button) -> void:
	if not is_instance_valid(button):
		return
	button.add_theme_color_override("font_color", Color(0.9, 0.9, 0.9))
	button.add_theme_stylebox_override("normal", _create_stylebox(Color(0.2, 0.4, 0.8)))
	button.add_theme_stylebox_override("hover", _create_stylebox(Color(0.3, 0.5, 0.9)))
	button.add_theme_stylebox_override("pressed", _create_stylebox(Color(0.1, 0.3, 0.7)))

static func secondary_button(button: Button) -> void:
	if not is_instance_valid(button):
		return
	button.add_theme_color_override("font_color", Color(0.9, 0.9, 0.9))
	button.add_theme_stylebox_override("normal", _create_stylebox(Color(0.3, 0.3, 0.3)))
	button.add_theme_stylebox_override("hover", _create_stylebox(Color(0.4, 0.4, 0.4)))
	button.add_theme_stylebox_override("pressed", _create_stylebox(Color(0.2, 0.2, 0.2)))

# Container styles
static func flex_container(container: Control) -> void:
	if not is_instance_valid(container):
		return
	container.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	container.size_flags_vertical = Control.SIZE_EXPAND_FILL

static func center_container(container: Control) -> void:
	if not is_instance_valid(container):
		return
	container.anchors_preset = Control.PRESET_CENTER
	container.grow_horizontal = Control.GROW_DIRECTION_BOTH
	container.grow_vertical = Control.GROW_DIRECTION_BOTH

# Text styles
static func heading(label: Label) -> void:
	if not is_instance_valid(label):
		return
	label.add_theme_font_size_override("font_size", 32)
	label.add_theme_color_override("font_color", Color(1, 1, 1))

static func subheading(label: Label) -> void:
	if not is_instance_valid(label):
		return
	label.add_theme_font_size_override("font_size", 24)
	label.add_theme_color_override("font_color", Color(0.9, 0.9, 0.9))

static func body_text(label: Label) -> void:
	if not is_instance_valid(label):
		return
	label.add_theme_font_size_override("font_size", 16)
	label.add_theme_color_override("font_color", Color(0.8, 0.8, 0.8))

# Helper function to create styleboxes
static func _create_stylebox(color: Color) -> StyleBoxFlat:
	var style = StyleBoxFlat.new()
	style.bg_color = color
	style.corner_radius_top_left = 4
	style.corner_radius_top_right = 4
	style.corner_radius_bottom_right = 4
	style.corner_radius_bottom_left = 4
	style.border_width_left = 0
	style.border_width_top = 0
	style.border_width_right = 0
	style.border_width_bottom = 0
	return style 