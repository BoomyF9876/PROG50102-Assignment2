extends CanvasLayer
@onready var key_label: Label = $KeyLabel
@onready var display_timer: Timer = $WinLabel/DisplayTimer
@onready var score_label: Label = $ScoreLabel
@onready var health_label: Label = $HealthLabel
@onready var win_label: Label = $WinLabel
@onready var player: Player = get_tree().get_first_node_in_group("Player") as Player
@onready var win_game_player: AudioStreamPlayer2D = $WinGamePlayer
@onready var level_label: Label = $LevelLabel

func _ready() -> void:
	player.health_changed.connect(_on_health_changed)
	player.score_changed.connect(_on_score_changed)
	player.key_acquired.connect(_on_key_obtained)
	player.win.connect(_on_win)

	player.set_score(player.score)
	player.set_health(player.health)
	level_label.text = "Level: " + str(GameManager.level)

func _on_health_changed(amount: int) -> void:
	health_label.text = "Health: %d / %d" %[amount, player.max_health]
	
func _on_score_changed(amount: int) -> void:
	score_label.text = "Score: " + str(amount)

func _on_key_obtained() -> void:
	key_label.text = "Key: " + str(player.key)
	key_label.show()
	
func _on_win() -> void:
	win_label.show()
	win_game_player.play()
	display_timer.start()
