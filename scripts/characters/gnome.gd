extends CharacterBody2D

@export var max_velocity: float = 100.0

var is_walking: bool = false
var current_button_index = -1

signal on_character_move(velocity: Vector2, max_velocity: float)

func _ready() -> void:
	$AnimatedSprite.connect("animation_looped", animation_looped)
	$AnimatedSprite.play("idle")

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed() && !is_walking && current_button_index < 0:
			is_walking = true
			if event.button_index == 2:
				$AnimatedSprite.play("tattooing_start")
				$Drawer.start_drawing(position)
			else:
				$AnimatedSprite.play("run")
			
			current_button_index = event.button_index
		
		if event.is_released() && is_walking && event.button_index == current_button_index:
			is_walking = false
			if event.button_index == 2:
				$AnimatedSprite.play("tattooing_end")
				$Drawer.stop_drawing(position)
			else:
				$AnimatedSprite.play("idle")
				
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
	stop_processing()
	$AnimatedSprite.play("lose_start")
	
func on_win() -> void:
	stop_processing()
	$AnimatedSprite.play("win_start")
	
func reset() -> void:
	position = Vector2(161, 91)
	is_walking = false
	$Drawer.stop_drawing(position)
	$Drawer.clear()
	$AnimatedSprite.play("idle")
	set_process(true)
	set_process_input(true)
	current_button_index = -1

func stop_processing() -> void:
	is_walking = false
	$Drawer.stop_drawing(position)
	set_process(false)
	set_process_input(false)
	current_button_index = -1
	
func animation_looped() -> void:
	if $AnimatedSprite.animation == "tattooing_end":
		$AnimatedSprite.play("idle")
	if $AnimatedSprite.animation == "tattooing_start":
		$AnimatedSprite.play("tattooing")
	if $AnimatedSprite.animation == "lose_start":
		$AnimatedSprite.play("lose_idle")
	if $AnimatedSprite.animation == "win_start":
		$AnimatedSprite.play("win_idle")
