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

var time: float
var timer: Timer

func _ready() -> void:
	$Sprite2D.visible = false
	_start_small_talk_timer()
	
func _process(delta: float) -> void:
	# wobble the cloud over time
	time += delta
	$Sprite2D.position[0] += sin(time * 4) / 50
	$Sprite2D.position[1] += cos(time * 2) / 50

func _on_ouch_threshold_exceeded() -> void:
	await _show_text(ouch_strings.pick_random(), 1.0, false)
	
func _show_text(text: String, duration: float = 3.0, play_audio: bool = true) -> void:
	$Sprite2D/LabelAutoSizer.text = text
	$Sprite2D.visible = true
	if play_audio:
		$AudioStreamPlayer.play()
	await get_tree().create_timer(duration).timeout
	$Sprite2D.visible = false
	
func _start_small_talk_timer() -> void:
	timer = Timer.new()
	add_child(timer)
	timer.one_shot = true
	timer.wait_time = randf_range(small_talk_min_wait_time, small_talk_max_wait_time)
	timer.timeout.connect(_on_timer_timeout)
	timer.start()

func _on_timer_timeout() -> void:
	if $Sprite2D.visible == false:
		await _show_text(small_talk_strings.pick_random())
	_start_small_talk_timer()
	
func on_failure(_fail_reason) -> void:
	timer.stop()
	$Sprite2D.visible = false
	
func on_win() -> void:
	timer.stop()
	$Sprite2D.visible = false
	
func reset() -> void:
	timer.stop()
	$Sprite2D.visible = false
	_start_small_talk_timer()
