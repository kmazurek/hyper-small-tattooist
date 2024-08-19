extends Control

signal on_tutorial_proceed

func _proceed() -> void:
	on_tutorial_proceed.emit()
