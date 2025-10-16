extends Node
class_name Game_Manager

var player: Player
var score: int = 0
var health: int = 0
var level: int = 0
var main_menu: PackedScene = preload("res://scenes/main_menu.tscn")
var level1: PackedScene = preload("res://scenes/level_1.tscn")
var level2: PackedScene = preload("res://scenes/level_2.tscn")

func _on_node_added(_node: Node) -> void:
	if _node is Player and not _node.is_connected(&"died", Callable(self, &"_on_player_died")):
		_node.died.connect(_on_player_died)
		_node.next_level.connect(next_level)
		_node.set_score(score)
		_node.set_health(health)
		player = _node

func _on_player_died() -> void:
	score = 0
	health = player.max_health
	get_tree().call_deferred("reload_current_scene")

func _ready() -> void:
	get_tree().node_added.connect(_on_node_added)
	
func start_game() -> void:
	level = 1
	get_tree().change_scene_to_packed(level1)
	
func next_level() -> void:
	if level == 2:
		level = 1
		score = 0
		health = player.max_health
		get_tree().change_scene_to_packed(level1)
	else:
		score = player.get_score()
		health = player.get_health()
		level = 2
		get_tree().change_scene_to_packed(level2)

func end_game() -> void:
	get_tree().call_deferred("change_scene_to_packed", main_menu)
	
