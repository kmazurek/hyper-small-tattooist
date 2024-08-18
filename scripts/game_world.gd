extends Node

signal on_failure

func _on_time_out() -> void:
	failure()

func _on_ink_depleted() -> void:
	failure()

func _on_pain_exceeded() -> void:
	failure()

func _on_next_client() -> void:
	save_screenshot()

func failure() -> void:
	on_failure.emit()
	
func save_screenshot() -> void:
	await RenderingServer.frame_post_draw
	var user_directory = DirAccess.open(OS.get_executable_path() + "/..")

	if !user_directory.dir_exists("tattoos"):
		user_directory.make_dir("tattoos")

	var screenshot_directory = DirAccess.open(user_directory.get_current_dir() + "/tattoos")
	var screenshots_num = screenshot_directory.get_files().size()
	
	$SubViewportContainer/SubViewport.get_texture().get_image().save_png(screenshot_directory.get_current_dir() + "/tattoo_" + str(screenshots_num) + ".png")
