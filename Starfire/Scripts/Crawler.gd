# CRAWLER
extends KinematicBody2D

signal dead

enum SHIP_STATES {ENTER,RETURN,IDLE,DIVE}
var ship_state = SHIP_STATES.ENTER

onready var area = get_node("Area2D")
var explosion = load("res://scenes/EnemyExplosion.tscn")
onready var immunity_timer = get_node("ImmunityTimer")
var motion_speed = 100
var immune = true

var idle_position = Vector2()
var return_point = 100
var order_number = 0
var row = 1
var timer = 0
var dive_timer=0
var dive_wait_time=0
var order=0
var HUD
var scoreValue = 100
var i = 0
var movement_variation = 0.0

func _ready():
	movement_variation+=rand_range(0.05,0.1)
	HUD = get_tree().get_nodes_in_group("HUD")[0]
	area.connect("body_entered", self, "on_area_entered")
	immunity_timer.connect("timeout",self,"on_immunity_timer_timeout")
	idle_position = Vector2(300,90)
	dive_wait_time=rand_range(1,7)

func _physics_process(delta):
	var motion = Vector2()
	
	if ship_state == SHIP_STATES.ENTER:
		motion.x = -1
		if global_position.x <= return_point:
			ship_state = SHIP_STATES.RETURN
	
	elif ship_state == SHIP_STATES.DIVE:
		i+=movement_variation
		motion.y = sin(i)
		motion.x=-1
		motion_speed=50
	
	elif ship_state == SHIP_STATES.RETURN:
		motion.x = 1
		if global_position.x >= idle_position.x:
			motion_speed=10
			ship_state=SHIP_STATES.IDLE
		
	elif ship_state == SHIP_STATES.IDLE:
		timer+=delta
		dive_timer+=delta
		if dive_timer>dive_wait_time:
			ship_state=SHIP_STATES.DIVE
			motion_speed=100
			return
			
		if timer > 1:
			timer = 0
			order+=1
		if order==0:
			pass
		elif order==1:
			motion.y=1
		elif order==2:
			pass
		elif order==3:
			motion.y=-1
		elif order==4:
			pass
		elif order==5:
			motion.y=-1
		elif order==6:
			pass
		elif order==7:
			motion.y=1
		elif order==8:
			order=0
		
	motion = motion.normalized() * motion_speed
	move_and_slide(motion)
	
func on_area_entered(body):
	if immune:
		return
		
	if body.is_in_group("PlayerLaser") or body.name == "Player":
		destroy()
		body.destroy()
		
func on_immunity_timer_timeout():
	immune = false
		
func destroy(explode=true):
	emit_signal("dead")
	if explode:
		HUD.update_score(scoreValue)
		var e = explosion.instance()
		get_parent().add_child(e)
		e.global_position = global_position
		
	self.queue_free()
