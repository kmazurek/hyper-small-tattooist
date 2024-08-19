class_name MainMenu extends Control

signal on_start
signal on_gallery_open
signal on_exit

func _enter_tree() -> void:
	$Logo/AnimationPlayer.play("open")
	await $Logo/AnimationPlayer.animation_finished
	$VBoxContainer.visible = true
	$VBoxContainer/Start/AnimatedSprite2D.play("idle")
	$Logo/AnimationPlayer.queue("idle")

func _on_start_pressed() -> void:
	$Logo/AnimationPlayer.play("close")
	$VBoxContainer/Start/AnimatedSprite2D.play("appear/out", -1, true)
	await $Logo/AnimationPlayer.animation_finished
	on_start.emit()

func _on_gallery_pressed() -> void:
	on_gallery_open.emit()

func _on_exit_pressed() -> void:
	on_exit.emit()
