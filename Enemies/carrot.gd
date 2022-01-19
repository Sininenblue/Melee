extends KinematicBody2D

export var health : int = 2
var current_health = health setget set_health

var speed : float = 70.0
var acceleration : float = 5.0

var direction : Vector2
var velocity : Vector2
var target = null

var is_charging : bool = false

onready var animation_player = $AnimationPlayer
onready var charge_timer = $ChargeTImer


func _ready():
	add_to_group("enemy")
	$RangeBox.add_to_group("enemy")
	$DetectionBox.add_to_group("enemy")
	$HurtBox.add_to_group("enemy")
	$HitBox.add_to_group("enemy")


func _physics_process(_delta):
	if target:
		if !is_charging:
			direction = position.direction_to(target.position)
		
		velocity = velocity.move_toward(direction * speed, acceleration)
		velocity = move_and_slide(velocity)

func _on_HurtBox_area_entered(area):
	if area.is_in_group("player_weapon"):
		#knockback
		self.current_health -= area.get_parent().get_parent().damage


func set_health(new_value):
	current_health = new_value
	
	if current_health <= 0:
		call_deferred("queue_free")


func _on_DetectionBox_body_entered(body):
	if "Player" in body.name:
		target = body


func _on_RangeBox_area_entered(area):
	if !area.is_in_group("enemy"):
		speed = 0
		animation_player.play("charge_up")


func _on_ChargeTImer_timeout():
	is_charging = false
	speed = 90.0
	acceleration = 5.0


func charge():
	charge_timer.start()
	direction = position.direction_to(target.position)
	speed = 500.0
	acceleration = speed


