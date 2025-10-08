extends Control

func _on_btn_start_pressed() -> void:
	#get_tree().change_scene_to_file("res://scenes/main.tscn")
	GameManager.start_game()

func _on_btn_quit_pressed() -> void:
	get_tree().quit()
