extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.player_hurt_feedback(Color(.6, .6, .6, 1));
