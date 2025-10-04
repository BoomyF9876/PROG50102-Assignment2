extends CanvasLayer

@onready var score_label: Label = $ScoreLabel
@onready var health_label: Label = $HealthLabel
@onready var player: Player = get_tree().get_first_node_in_group("Player") as Player

func _ready() -> void:
	player.health_changed.connect(_on_health_changed)
	player.score_changed.connect(_on_score_changed)
	player.died.connect(_on_died)
	
	player.set_score(0)
	player.set_health(player.max_health)

func _on_health_changed(amount: int) -> void:
	health_label.text = "Health: %d / %d" %[amount, 100]
	
func _on_score_changed(amount: int) -> void:
	score_label.text = "Score: " + str(amount)
	
func _on_died() -> void:
	get_tree().call_deferred("reload_current_scene")
