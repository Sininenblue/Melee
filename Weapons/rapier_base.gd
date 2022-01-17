extends Node2D

export var damage : int = 1
export var dash_strength : float = 200

onready var animation_player = $AnimationPlayer
onready var holder = get_parent()


func _ready():
	$Sprite/Hitbox.add_to_group("player_weapon")


func _input(event):
	if event.is_action_pressed("primary_attack") and !animation_player.is_playing():
		holder.velocity += dash_strength * global_position.direction_to(get_global_mouse_position())
		animation_player.play("primary_attack")
	if event.is_action_pressed("secondary_attack") and !animation_player.is_playing():
		animation_player.play("secondary_attack")


func _physics_process(delta):
	look_at(get_global_mouse_position())
