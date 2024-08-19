extends Control

signal on_restart

@onready var anim_player: AnimationPlayer = $AnimatedSprite2D/AnimationPlayer

func _ready() -> void:
	$VBoxContainer.visible = false
	anim_player.play("default")
	await get_tree().create_timer(1.5).timeout
	$VBoxContainer.visible = true

func _on_restart_clicked() -> void:
	on_restart.emit()
	queue_free()
