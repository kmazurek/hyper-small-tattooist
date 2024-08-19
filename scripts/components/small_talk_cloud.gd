extends Node

var ouch_strings: Array[String] = [
	"Ouch!!",
	"Ungghh",
	"Tickles!",
	"Stings!",
	"Ow!"
]

var small_talk_strings: Array[String] = [
	"Humans tasty",
	"Cool place",
	"Like my axe?",
	"Is it good?",
	"I'm hungry"
]

const small_talk_min_wait_time: float = 8.0
const small_talk_max_wait_time: float = 12.0

func _ready() -> void:
	$Sprite2D.visible = false
	_start_small_talk_timer()

func _on_ouch_threshold_exceeded() -> void:
	await _show_text(ouch_strings.pick_random(), 1.0)
	
func _show_text(text: String, duration: float = 3.0) -> void:
	$Sprite2D/LabelAutoSizer.text = text
	$Sprite2D.visible = true
	await get_tree().create_timer(duration).timeout
	$Sprite2D.visible = false
	
func _start_small_talk_timer() -> void:
	var timer: Timer = Timer.new()
	add_child(timer)
	timer.one_shot = true
	timer.wait_time = randf_range(small_talk_min_wait_time, small_talk_max_wait_time)
	timer.timeout.connect(_on_timer_timeout)
	timer.start()

func _on_timer_timeout() -> void:
	if $Sprite2D.visible == false:
		await _show_text(small_talk_strings.pick_random())
	_start_small_talk_timer()
