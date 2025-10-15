extends Node

var player: Player
var score: int = 0
var health: int = 0
var main_menu: PackedScene = preload("res://scenes/main_menu.tscn")
var level1: PackedScene = preload("res://scenes/level_1.tscn")
var level2: PackedScene = preload("res://scenes/level_2.tscn")

## Will search for a player, when a node enters the scene[br]
## [codeblock]
## var player: Player = get_tree().get_first_in_group("Player")
## if not player.is_connected(&"died", Callable(self, &"_on_player_died"))
## [/codeblock]
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
	get_tree().change_scene_to_packed(level1)
	
func next_level() -> void:
	if get_tree().current_scene.name == "Level2":
		end_game()
	else:
		score = player.get_score()
		health = player.get_health()
		get_tree().change_scene_to_packed(level2)

func end_game() -> void:
	get_tree().call_deferred("change_scene_to_packed", main_menu)
	
