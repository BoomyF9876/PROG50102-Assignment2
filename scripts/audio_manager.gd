extends Node

@onready var music_player: AudioStreamPlayer = $MusicPlayer
@onready var ui_player: AudioStreamPlayer = $UIPlayer
@onready var sfx_player: AudioStreamPlayer2D = $SfxPlayer

const SFX := {
	"coin": preload("res://assets/kenney_new-platformer-pack-1.0/Sounds/sfx_gem.ogg"),
	"jump": preload("res://assets/kenney_new-platformer-pack-1.0/Sounds/sfx_jump.ogg"),
	"hurt": preload("res://assets/kenney_new-platformer-pack-1.0/Sounds/sfx_hurt.ogg")
};

const MUSIC := {
	&"level1": preload("res://assets/Clement Panchout/2016_ Clement Panchout_ Life is full of Joy.wav")
}

func _ready() -> void:
	play_music(&"level1")

func play_music(music_name: StringName) -> void:
	var stream: AudioStream = MUSIC.get(music_name, null)
	if stream == null:
		push_warning("Unknown Music: %s" % String(music_name))
		return
		
	music_player.stream = stream
	music_player.play()
			
func stop_music() -> void:
	music_player.stop()

func play_at(sfx_name: StringName, pos: Vector2) -> void:
	var stream: AudioStream = SFX.get(sfx_name, null)
	if stream == null:
		push_warning("SFX not found: %s" % String(sfx_name))
		return
		
	var p := AudioStreamPlayer2D.new()
	p.stream = stream
	p.bus = sfx_player.bus
	p.global_position = pos
	add_child(p)
	p.finished.connect(p.queue_free)
	p.play()
	
	
	
		
		
	
