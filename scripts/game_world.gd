extends Node


func _on_pain_exceeded() -> void:
	await RenderingServer.frame_post_draw
	$SubViewportContainer/SubViewport.get_texture().get_image().save_png("user://Screenshot.png")
