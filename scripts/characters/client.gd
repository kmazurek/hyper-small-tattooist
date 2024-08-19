extends AnimatedSprite2D

@onready var pain_bar = $"../../../PainBar/Bar" as ProgressBar

var previous_pain = 0

func _ready() -> void:
	play("idle")
	
func _process(delta: float) -> void:
	var current_pain = pain_bar.value
	if current_pain - previous_pain > 0:
		play("pain")
	elif current_pain - previous_pain <= 0:
		play("idle")
		
	previous_pain = current_pain

func on_win() -> void:
	set_process(false)
	play("happy")
	
func on_failure() -> void:
	set_process(false)
	play("angry")

func reset() -> void:
	set_process(true)
	play("idle")
	previous_pain = 0
