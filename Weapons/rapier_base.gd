extends Node2D

export var damage : int = 1
export var recovery_speed : float = .1
export var dash_strength : float = 200

onready var animation_player = $AnimationPlayer
onready var holder = get_parent()


func _ready():
	$Sprite/Hitbox.add_to_group("player_weapon")
	animation_player.play("RESET")


func _input(event):
	if event.is_action_pressed("primary_attack") and is_animation_interruptable():
		holder.velocity += dash_strength * global_position.direction_to(get_global_mouse_position())
		animation_player.stop()
		animation_player.play("primary_attack")
	if event.is_action_pressed("secondary_attack") and is_animation_interruptable():
		animation_player.play("secondary_attack")


func _physics_process(_delta):
	$Sprite.flip_v = global_position.x > get_global_mouse_position().x
	
	rotation = global_position.angle_to_point(get_global_mouse_position()) - PI


func is_animation_interruptable():
	if animation_player.current_animation_position < animation_player.current_animation_length - recovery_speed:
		return false
	else: return true
