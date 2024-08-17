extends ProgressBar

signal time_out

func _ready() -> void:
	reset()

func _process(delta: float) -> void:
	value = value - delta
	
	if value <= 0:
		time_out.emit()

func reset():
	value = max_value
