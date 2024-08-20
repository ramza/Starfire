# PLAYER
extends KinematicBody2D


const MOTION_SPEED = 50 # Pixels/second
onready var sprite = get_node("Sprite")
onready var anim = get_node("AnimationPlayer")

var explosion = load("res://scenes/PlayerExplosion.tscn")

enum DIRECTION {UP,DOWN,LEFT,RIGHT}

var HUD
var direction = DIRECTION.DOWN
var facing_right = false

func _ready():
	HUD = get_tree().get_nodes_in_group("HUD")[0]
	
func destroy():
	HUD.game_over()
	Global.game_over=true
	var e = explosion.instance()
	get_parent().add_child(e)
	e.global_position = global_position
	queue_free()

func _physics_process(_delta):
	
	var motion = Vector2()
	motion.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	motion.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")

	motion.y /= 2
	motion = motion.normalized() * MOTION_SPEED
	#warning-ignore:return_value_discarded
	move_and_slide(motion)
	
	if Input.is_action_pressed("move_down") and motion.y!=0:
		anim.play("Fly_Down")
	elif Input.is_action_pressed("move_up") and motion.y!=0:
		anim.play("Fly_Up")
	else:
		anim.play("Fly")
			
