extends Control

signal on_restart

func _on_restart_clicked() -> void:
	on_restart.emit()
	queue_free()
