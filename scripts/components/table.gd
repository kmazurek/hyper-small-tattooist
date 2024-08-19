extends Node2D

signal on_time_out

@export var time: float = 10.0

var current_time: float = 0.0

func _ready() -> void:
	current_time = time

func _process(delta: float) -> void:
	current_time -= delta
	$TimerArrrow.global_rotation_degrees = 360.0 * (current_time / time)

	if current_time <= 0.0:
		$TimerArrrow.rotation = 0
		set_process(false)
		on_time_out.emit()

func on_failure() -> void:
	set_process(false)
