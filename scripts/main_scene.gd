extends Node

@onready var main_menu_scene = preload("res://scenes/game_scenes/main_menu.tscn")
@onready var game_scene = preload("res://scenes/game_scenes/game_scene.tscn")

var main_menu_instance: Node
var game_instance: Node

func _ready() -> void:
	main_menu_instance = main_menu_scene.instantiate()
	$GUI.add_child(main_menu_instance)
