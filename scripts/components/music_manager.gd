extends AudioStreamPlayer

@onready var bgm1 = preload("res://assets/audio/music/bgm1.ogg")
@onready var bgm2 = preload("res://assets/audio/music/bgm2.ogg")
@onready var bgm3 = preload("res://assets/audio/music/bgm3.ogg")

var streams: Array[AudioStream]
var current_index: int = 0

func _ready() -> void:
	streams = [bgm1, bgm2, bgm3]
	stream = streams[current_index]
	play()

func _on_playback_finished() -> void:
	current_index += 1
	stream = streams[current_index % len(streams)]
	play()
