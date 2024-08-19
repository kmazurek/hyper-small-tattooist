extends Node

var ouch_strings: Array[String] = [
	"Ouch!!",
	"Ungghh",
	"That tickles!",
	"That stings!",
	"Oww!"
]

func _ready() -> void:
	$Sprite2D.visible = false

func _on_ouch_threshold_exceeded() -> void:
	await _show_text(ouch_strings.pick_random())
	
func _show_text(text: String, duration: float = 3.0) -> void:
	$Sprite2D/LabelAutoSizer.text = text
	$Sprite2D.visible = true
	await get_tree().create_timer(duration).timeout
	$Sprite2D.visible = false
