extends Node2D

var lines: Array[Line2D] = []
var current_line = Line2D

var is_drawing: bool = false

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton && event.button_index == 1:
		is_drawing = event.pressed
		
		if event.pressed:
			current_line = Line2D.new()
			lines.push_back(current_line)
			get_parent().add_child(current_line)
	
	if event is InputEventMouseMotion && is_drawing:
		current_line.add_point(event.position)
