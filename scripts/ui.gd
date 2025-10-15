extends CanvasLayer
@onready var key_label: Label = $KeyLabel
@onready var display_timer: Timer = $WinLabel/DisplayTimer
@onready var score_label: Label = $ScoreLabel
@onready var health_label: Label = $HealthLabel
@onready var win_label: Label = $WinLabel
@onready var player: Player = get_tree().get_first_node_in_group("Player") as Player

func _ready() -> void:
	player.health_changed.connect(_on_health_changed)
	player.score_changed.connect(_on_score_changed)
	player.key_acquired.connect(_on_key_obtained)
	player.died.connect(_on_restart)
	player.win.connect(_on_win)
	
	player.set_score(0)
	player.set_health(player.max_health)

func _on_health_changed(amount: int) -> void:
	health_label.text = "Health: %d / %d" %[amount, player.max_health]
	
func _on_score_changed(amount: int) -> void:
	score_label.text = "Score: " + str(amount)

func _on_key_obtained() -> void:
	key_label.text = "Key: " + str(player.key)
	key_label.show()
	
func _on_restart() -> void:
	get_tree().call_deferred("reload_current_scene")
	
func _on_win() -> void:
	win_label.show()
	display_timer.start()

func _on_display_timer_timeout() -> void:
	_on_restart()
