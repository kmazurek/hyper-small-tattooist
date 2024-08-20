class_name FailScreen extends Control

signal on_restart

@onready var jaws_anim: AnimationPlayer = $JawsSprite/AnimationPlayer
@onready var game_over_anim: AnimationPlayer = $GameOverSprite/AnimationPlayer

func _ready() -> void:
	jaws_anim.play("default")
	await jaws_anim.animation_finished
	game_over_anim.play("open")
	$GameOverSprite.visible = true
	await game_over_anim.animation_finished
	$VBoxContainer.visible = true
	game_over_anim.play("idle")

func _on_restart_clicked() -> void:
	game_over_anim.play("close")
	await game_over_anim.animation_finished
	on_restart.emit()
	queue_free()

func set_failure_text(failure_reason) -> void:
	$VBoxContainer/Label.text = failure_reason
