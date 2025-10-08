extends CharacterBody2D
class_name Player

signal health_changed(amount: int)
signal score_changed(amount: int)
## This signal will be broadcasted if the player dies
signal died()
signal win()

@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0
@onready var aSprite: AnimatedSprite2D = $AnimatedSprite2D

@export var invincible_duration: float = 0.8
@export var flash_interval: float = 0.08
@export var hurt_tint: Color = Color(1, .6, .6, 1)
@export var _is_invincible: bool = false
var _base_modulate: Color = Color(1,1,1,1)

@onready var sfx_hurt: AudioStreamPlayer2D = $SfxHurt
@onready var sfx_jump: AudioStreamPlayer2D = $SfxJump
@onready var i_frames_timer: Timer = $IFramesTimer
@onready var flash_timer: Timer = $FlashTimer

var _score: int = -1
var _health: int = 0
@export var max_health: int = 5

var score: set = set_score, get = get_score
var health: set = set_health, get = get_health

func _ready() -> void:
	_base_modulate = aSprite.modulate
	#i_frames_timer.timeout.connect(_on_i_frames_timer_timeout)
	#flash_timer.timeout.connect(_on_flash_timer_timeout)

func _on_i_frames_timer_timeout() -> void:
	_is_invincible = false
	flash_timer.stop()
	visible = true
	aSprite.modulate = _base_modulate

func _on_flash_timer_timeout() -> void:
	visible = not visible

func set_health(amount: int) -> void:
	var clamped := clampi(amount, 0, max_health)
	if clamped != _health:
		_health = clamped
		emit_signal("health_changed", _health)
		if _health <= 0:
			emit_signal("died")
func get_health() -> int:
	return _health
	
func set_score(amount: int) -> void:
	if _score != amount:
		_score = amount
		emit_signal("score_changed", _score)
func get_score() -> int:
	return _score
	
func add_score(amount: int) -> void:
	score += amount
func take_damage(amount: int) -> void:
	if _is_invincible: return
	health -= amount
	#if sfx_hurt and sfx_hurt.stream:
		#sfx_hurt.play()
	AudioManager.play_at(&"hurt", global_position)
	player_hurt_feedback(hurt_tint)

func player_hurt_feedback(_color: Color) -> void:
	_is_invincible = true
	aSprite.modulate = _color
	flash_timer.wait_time = flash_interval
	flash_timer.start()
	i_frames_timer.start(invincible_duration)
	
func take_heal(amount: int) -> void:
	health += amount
	
func win_game() -> void:
	emit_signal("win")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		if sfx_jump and sfx_jump.stream:
			sfx_jump.play()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction < 0:
		aSprite.flip_h = true
	else:
		aSprite.flip_h = false
	
	if is_on_floor():
		if direction == 0:
			aSprite.play("idle")
		else:
			aSprite.play("run")
	else:
		aSprite.play("jump")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 10.0)

	move_and_slide()
