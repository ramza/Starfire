# PLAYER LASER
extends KinematicBody2D

const MOTION_SPEED = -400

func _ready():
	pass 

func _physics_process(delta):
	var motion = Vector2()
	motion.x = -1
	
	motion = motion.normalized()*MOTION_SPEED
	move_and_slide(motion)
	
func destroy():
	queue_free()
