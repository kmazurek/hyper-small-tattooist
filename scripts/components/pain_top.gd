extends AnimatedSprite2D

@export var y_offset = -2

var progress_bar: ProgressBar
var bar_height: float

func _ready() -> void:
	for child in get_parent().get_children():
		if child is ProgressBar:
			progress_bar = child as ProgressBar
			break
	
	bar_height = progress_bar.size.x
	play("Tag")
	

func _process(delta: float) -> void:
	position.y = -bar_height * progress_bar.value / progress_bar.max_value + y_offset
