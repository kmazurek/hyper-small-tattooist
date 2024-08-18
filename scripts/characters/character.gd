extends CharacterBody2D

@export var max_velocity: float = 100.0

var is_walking: bool = false
var is_drawing: bool = false
var current_button_index = -1

signal on_character_move(velocity: Vector2, max_velocity: float)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed() && !is_walking && current_button_index < 0:
			is_walking = true
			if event.button_index == 2:
				$Drawer.start_drawing(position)
			
			current_button_index = event.button_index
		
		if event.is_released() && is_walking && event.button_index == current_button_index:
			is_walking = false
			if event.button_index == 2:
				$Drawer.stop_drawing(position)
				
			current_button_index = -1

func _process(delta: float) -> void:
	$Drawer.update_line(position)
	
	if is_walking:
		var mouse_position = get_global_mouse_position()
		
		velocity = mouse_position - position
		velocity = velocity.normalized() * clampf(velocity.length(), 0, max_velocity)
		move_and_slide()
		if $Drawer.is_drawing:
			on_character_move.emit(velocity, max_velocity)

func on_failure() -> void:
	is_walking = false
	$Drawer.stop_drawing(position)
	set_process(false)
	set_process_input(false)
	current_button_index = -1

func reset() -> void:
	is_walking = false
	$Drawer.stop_drawing(position)
	$Drawer.clear()
	set_process(true)
	set_process_input(true)
	current_button_index = -1
