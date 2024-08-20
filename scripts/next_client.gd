class_name NextScreen extends Control

signal on_next

func _on_next_clicked() -> void:
	on_next.emit()
	queue_free()

func show_thank_you(show) -> void:
	$Thanks.visible = show
