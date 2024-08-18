class_name Drawer extends Node2D

@export var color: Color
@export var width_curve: Curve

var viewport: SubViewport
var current_line: Line2D

var is_drawing: bool = false

func _ready() -> void:
	viewport = get_tree().root.find_child("SubViewport", true, false) as SubViewport

func start_drawing(current_position: Vector2) -> void:
	is_drawing = true
	
	current_line = Line2D.new()
	current_line.default_color = color
	current_line.width_curve = width_curve
	current_line.width = 4
	current_line.visibility_layer = 2
	viewport.add_child(current_line)
	
	current_line.add_point(current_position)
	
func update_line(current_position: Vector2) -> void:
	if is_drawing:
		current_line.add_point(current_position)
		
func stop_drawing(current_position: Vector2) -> void:
	current_line.add_point(current_position)
	is_drawing = false
