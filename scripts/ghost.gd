extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@export var amount: int = 1
@export var speed: int = 50
@export var dir: Vector2
var start_pos: Vector2
var target_pos: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_pos = global_position
	target_pos = start_pos + dir

func _process(delta: float) -> void:
	global_position = global_position.move_toward(target_pos, speed * delta)
	if global_position == target_pos:
		if global_position == start_pos:
			target_pos = start_pos + dir
		else:
			target_pos = start_pos
	
	var move_dir:= (target_pos - global_position).normalized()
	if abs(move_dir.x) > abs(move_dir.y):
		animated_sprite_2d.flip_h = move_dir.x > 0	
		
func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.take_damage(amount)
