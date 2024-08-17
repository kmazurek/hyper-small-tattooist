extends CanvasLayer

func _process(delta: float) -> void:
	$Control/ColorRect.color.a = $Control/ColorRect.color.a - delta

func _flash() -> void:
	$Control/ColorRect.color.a = 1.0
