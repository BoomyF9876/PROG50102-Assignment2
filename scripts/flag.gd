extends Area2D

@onready var reload_timer: Timer = $ReloadTimer
@onready var player: Player = get_tree().get_first_node_in_group("Player") as Player

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		if get_tree().current_scene.name == "Level2":
			reload_timer.wait_time = 2
			body.win_game()
		else:		
			reload_timer.wait_time = 0.5
		reload_timer.start()

func _on_reload_timer_timeout() -> void:
	player.proceed_next_level()
