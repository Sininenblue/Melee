extends KinematicBody2D

export var health : int = 2
var current_health = health setget set_health


func _physics_process(delta):
	pass


func _on_HurtBox_area_entered(area):
	if area.is_in_group("player_weapon"):
		#knockback
		self.current_health -= area.get_parent().get_parent().damage


func set_health(new_value):
	current_health = new_value
	
	if current_health <= 0:
		call_deferred("queue_free")
