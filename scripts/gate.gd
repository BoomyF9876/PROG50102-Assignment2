extends StaticBody2D

@onready var gate_sound_player_2d: AudioStreamPlayer2D = $GateSoundPlayer2D

func _on_gate_sound_player_2d_finished() -> void:
	queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		if (body.key > 0):
			body.set_key(-1)
			gate_sound_player_2d.play()
