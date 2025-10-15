extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_right: RayCast2D = $RayRight
@onready var ray_left: RayCast2D = $RayLeft
@export var amount: int = 1
@export var speed_y: int = -15000
@export var speed_x: int = 5000
@export var dir: Vector2
var direction: int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		velocity.x = direction * delta * speed_x
	else:
		velocity.y = delta * speed_y
		
	if ray_right.is_colliding():
		direction = -1
		animated_sprite_2d.flip_h = true
	if ray_left.is_colliding():
		direction = 1
		animated_sprite_2d.flip_h = false
	move_and_slide()
		
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		body.take_damage(amount)
