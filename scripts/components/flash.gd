extends CanvasLayer

@onready var flash_sound = preload("res://assets/audio/sfx/polaroid-flash.ogg")

func _process(delta: float) -> void:
	$Control/ColorRect.color.a = $Control/ColorRect.color.a - delta

func flash() -> void:
	$Control/ColorRect.color.a = 1.0
	$AudioStreamPlayer.stream = flash_sound
	$AudioStreamPlayer.play()
