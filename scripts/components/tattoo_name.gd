extends Sprite2D

var tattoo_themes: Array[String] = [
	"Feroucious duck",
	"Brutal crab",
	"Stinky hammer",
	"Elephant skull"
]

func _ready() -> void:
	reload_theme()

func reload_theme() -> void:
	$Label.text = tattoo_themes.pick_random()
