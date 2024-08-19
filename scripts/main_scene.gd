extends Node

@onready var main_menu_scene = preload("res://scenes/game_scenes/main_menu.tscn")
@onready var game_scene = preload("res://scenes/game_scenes/game_scene.tscn")
@onready var failure_screen = preload("res://scenes/game_scenes/fail_screen.tscn")
@onready var screenshot_directory = OS.get_executable_path() + "/../tattoos"

var main_menu_instance: MainMenu
var game_instance: GameWorld
var failure_screen_instance: Control

func _ready() -> void:
	if !DirAccess.dir_exists_absolute(screenshot_directory):
		DirAccess.make_dir_absolute(screenshot_directory)
	
	spawn_menu()

func spawn_menu() -> void:
	main_menu_instance = main_menu_scene.instantiate() as MainMenu
	main_menu_instance.on_start.connect(start_game)
	main_menu_instance.on_gallery_open.connect(open_gallery)
	main_menu_instance.on_exit.connect(exit)
	
	$GUI.add_child(main_menu_instance)

func spawn_failure_screen() -> void:
	failure_screen_instance = failure_screen.instantiate()
	failure_screen_instance.connect("on_restart", restart_game)
	$GUI.add_child(failure_screen_instance)

func start_game() -> void:
	main_menu_instance.queue_free()
	spawn_game()

func restart_game() -> void:
	game_instance.free()
	spawn_game()

func open_gallery() -> void:
	OS.shell_show_in_file_manager(screenshot_directory)

func exit() -> void:
	get_tree().quit()

func spawn_game() -> void:
	game_instance = game_scene.instantiate()
	game_instance.connect("on_failure", spawn_failure_screen)
	add_child(game_instance)
