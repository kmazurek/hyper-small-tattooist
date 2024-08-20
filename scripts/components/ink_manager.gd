extends Node

@export var depletion_step: float = 1.1

signal on_ink_depleted

var is_active: bool = true

func _on_character_move(velocity: Vector2, max_velocity: float) -> void:
	$Bar.value -= depletion_step
	if $Bar.value <= 0.0 && is_active:
		is_active = false
		on_ink_depleted.emit()

func reset() -> void:
	is_active = true
	$Bar.value = 100
