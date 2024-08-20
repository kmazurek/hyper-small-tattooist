class_name GameWorld extends Node

signal on_failure
signal on_win
signal on_game_finished
signal on_new_client

var client_count: int = 10

func _on_time_out() -> void:
	failure()

func _on_ink_depleted() -> void:
	$Flash.flash()
	
	await RenderingServer.frame_post_draw
	save_screenshot()
	on_win.emit()

func _on_pain_exceeded() -> void:
	failure()

func game_finished() -> void:
	on_game_finished.emit()

func failure() -> void:
	on_failure.emit()
	
func save_screenshot() -> void:
	var user_directory = DirAccess.open(OS.get_executable_path() + "/..")

	if !user_directory.dir_exists("tattoos"):
		user_directory.make_dir("tattoos")

	var screenshot_directory = DirAccess.open(user_directory.get_current_dir() + "/tattoos")
	var screenshots_num = screenshot_directory.get_files().size()
	
	var texture = $SubViewportContainer/SubViewport.get_texture()
	var saved_png_path = screenshot_directory.get_current_dir() + "/tattoo_" + str(screenshots_num) + ".png"
	texture.get_image().save_png(saved_png_path)
	
	var image = Image.new()
	image.load(saved_png_path)
	var new_texture = ImageTexture.new()
	new_texture.set_image(image)
	$Polaroid.texture = new_texture

func new_client() -> void:
	client_count -= 1
	if client_count == 0:
		on_game_finished.emit()
		return
	
	$ClientCount.frame = client_count - 1
	reset_children(self)
	
	on_new_client.emit()

func reset_children(root):
	for child in root.get_children():
		reset_children(child)
		
		if child.has_method("reset"):
			child.reset()

func show_polaroid():
	$Polaroid.visible = true
	
func hide_polaroid():
	$Polaroid.visible = false
