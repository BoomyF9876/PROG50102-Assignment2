extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_right: RayCast2D = $RayRight
@onready var ray_left: RayCast2D = $RayLeft
@export var amount: int = 1
@export var speed: int = 150
var direction: int = -1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ray_right.is_colliding():
		direction = -1
		animated_sprite_2d.flip_h = false
	if ray_left.is_colliding():
		direction = 1
		animated_sprite_2d.flip_h = true

	position.x += speed * direction * delta	

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.take_damage(amount)
