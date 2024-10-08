extends AnimatedSprite2D

@export var type_of_client: Array[SpriteFrames] = []

@onready var anim_player = $AnimationPlayer as AnimationPlayer
@onready var orc_collision = $OrcCollision
@onready var giant_collision = $GiantCollision

var current_collision: Node = null

func _ready() -> void:
	anim_player.play("idle")
	on_new_client()

func _on_ouch_threshold_exceeded() -> void:
	$AudioStreamPlayer.play()
	anim_player.play("pain")
	anim_player.queue("idle")

func on_new_client() -> void:
	sprite_frames = type_of_client.pick_random() as SpriteFrames
	if current_collision != null:
		current_collision.reparent(self)

	if sprite_frames.resource_path.contains("Orc"):
		current_collision = orc_collision
		current_collision.call_deferred("reparent", $"../../..")
		
	if sprite_frames.resource_path.contains("Giant"):
		current_collision = giant_collision
		current_collision.call_deferred("reparent", $"../../..")

func on_win() -> void:
	set_process(false)
	anim_player.play("happy")
	
func on_failure(_fail_reason) -> void:
	set_process(false)
	anim_player.play("angry")

func reset() -> void:
	set_process(true)
	anim_player.play("idle")
