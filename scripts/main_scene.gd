extends Node

@onready var main_menu_scene = preload("res://scenes/game_scenes/main_menu.tscn")
@onready var game_scene = preload("res://scenes/game_scenes/game_scene.tscn")
@onready var failure_screen = preload("res://scenes/game_scenes/fail_screen.tscn")
@onready var next_screen = preload("res://scenes/game_scenes/next_client.tscn")
@onready var screenshot_directory = OS.get_executable_path() + "/../tattoos"
@onready var tutorial_screen = preload("res://scenes/game_scenes/tutorial_screen.tscn")

@onready var curtain_open_sound = preload("res://assets/audio/sfx/curtain-open.ogg")
@onready var curtain_close_sound = preload("res://assets/audio/sfx/curtain-close.ogg")
@onready var photo_print_sound = preload("res://assets/audio/sfx/polaroid-print.ogg")
@onready var confetti_sound = preload("res://assets/audio/sfx/confetti.ogg")

var main_menu_instance: MainMenu
var game_instance: GameWorld
var next_screen_instance: NextScreen
var failure_screen_instance: Control
var tutorial_screen_instance: Control

signal button_pressed

func _input(event: InputEvent) -> void:
	if event.is_pressed():
		button_pressed.emit()

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

func spawn_failure_screen(failure_reason) -> void:
	failure_screen_instance = failure_screen.instantiate() as FailScreen
	failure_screen_instance.connect("on_restart", restart_game)
	failure_screen_instance.set_failure_text(failure_reason)
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
	game_instance.connect("on_win", spawn_next_screen)
	game_instance.connect("on_new_client", open_curtain)
	game_instance.connect("on_game_finished", game_finished)
	open_curtain()
	$FakeBackground.visible = false
	add_child(game_instance)

func spawn_tutorial() -> void:
	main_menu_instance.queue_free()
	tutorial_screen_instance = tutorial_screen.instantiate()
	tutorial_screen_instance.connect("on_tutorial_proceed", start_game)
	$GUI.add_child(tutorial_screen_instance)

func spawn_next_screen() -> void:
	$Continue.visible = true
	await button_pressed
	$Continue.visible = false
	$AudioStreamPlayer.stream = curtain_close_sound
	$AudioStreamPlayer.play()
	$Curtain/AnimationPlayer.play("open_close", -1, -1.0, true)
	await $Curtain/AnimationPlayer.animation_finished
	
	$Confetti.visible = true
	$Confetti/AnimationPlayer.play("default")
	$AudioStreamPlayer.stream = confetti_sound
	$AudioStreamPlayer.play()
	await $Confetti/AnimationPlayer.animation_finished
	$Confetti.visible = false
	
	$AudioStreamPlayer.stream = photo_print_sound
	$AudioStreamPlayer.play()
	game_instance.show_polaroid(get_tree().create_tween())
	next_screen_instance = next_screen.instantiate()
	next_screen_instance.connect("on_next", game_instance.new_client)
	next_screen_instance.show_thank_you(game_instance.client_count <= 1)
	$GUI.add_child(next_screen_instance)
	
func open_curtain() -> void:
	game_instance.hide_polaroid(get_tree().create_tween())
	$AudioStreamPlayer.stream = curtain_open_sound
	$AudioStreamPlayer.play()
	$Curtain/AnimationPlayer.play("open_close")
	
func game_finished() -> void:
	game_instance.queue_free()
	$FakeBackground.visible = true
	spawn_menu()
