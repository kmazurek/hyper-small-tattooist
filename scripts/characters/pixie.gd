extends Node2D

var character: Node2D

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	
	character = get_tree().root.find_child("Gnome", true, false)
	$AnimSprite.play("idle")

func _process(delta: float) -> void:
	position = get_global_mouse_position()
	
	$AnimSprite.flip_h = position.x > character.position.x
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			$AnimSprite.play("active")
		else:
			$AnimSprite.play("idle")

func _on_failure(_fail_reason) -> void:
	stop_processing()
	$AnimSprite.play("lose_idle")

func _on_win() -> void:
	stop_processing()
	$AnimSprite.play("win_start")

func reset() -> void:
	start_processing()
	$AnimSprite.play("idle")
	
func stop_processing() -> void:
	set_process_input(false)
	set_process(false)
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func start_processing() -> void:
	set_process_input(true)
	set_process(true)
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

func _on_anim_sprite_animation_looped() -> void:
	if $AnimSprite.get_animation() == "win_start":
		$AnimSprite.play("win_idle")
