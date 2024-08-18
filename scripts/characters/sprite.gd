extends Node2D

var character: Node2D

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	
	character = get_tree().root.find_child("Character", true, false)
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


func _on_pain_exceeded() -> void:
	set_process_input(false)
	$AnimSprite.play("lose_idle")
