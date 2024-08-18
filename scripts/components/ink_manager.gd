extends Node

@export var depletion_step: float = 0.025

signal on_ink_depleted

func _on_character_move(velocity: Vector2, max_velocity: float) -> void:
	$Bar.value -= depletion_step
	if $Bar.value <= 0.0:
		on_ink_depleted.emit()
