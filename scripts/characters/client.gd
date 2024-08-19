extends AnimatedSprite2D

@onready var anim_player = $AnimationPlayer as AnimationPlayer

func _ready() -> void:
	anim_player.play("idle")

func _on_ouch_threshold_exceeded() -> void:
	$AudioStreamPlayer.play()
	anim_player.play("pain")
	anim_player.queue("idle")

func on_win() -> void:
	set_process(false)
	anim_player.play("happy")
	
func on_failure() -> void:
	set_process(false)
	anim_player.play("angry")

func reset() -> void:
	set_process(true)
	anim_player.play("idle")
