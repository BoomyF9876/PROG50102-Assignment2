extends Area2D

@export var value: int = 1
@onready var start_y: float = position.y
var bob_height: float = 25.0
var bob_speed: float = 5.0
var t: float = 0

func _process(_delta: float) -> void:
	t += _delta
	var d = (sin(t*bob_speed) + 1) / 2
	position.y = start_y + (d*bob_height)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.add_score(value)
		$AudioStreamPlayer2D.play()

func _on_audio_stream_player_2d_finished() -> void:
	queue_free()
	pass
