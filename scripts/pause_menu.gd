extends Control

@onready var main = $"../../../"

func _on_btn_quit_pressed() -> void:
	get_tree().quit()

func _on_btn_resume_pressed() -> void:
	main.pause_game()
