extends KinematicBody2D

var speed : float = 100.0
var acceleration : float = 20.0

var input : Vector2
var velocity : Vector2


func _physics_process(delta):
	# movement
	input = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = velocity.move_toward(input * speed, acceleration)
	
	velocity = move_and_slide(velocity)
