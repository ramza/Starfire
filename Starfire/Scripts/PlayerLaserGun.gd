# PLAYER LASER GUN
extends Node2D

var laser = load("res://scenes/PlayerLaser.tscn")
var can_fire = true
var ship

onready var timer = get_node("Timer")

func _ready():
	ship = get_parent()
	timer.connect("timeout",self,"on_cooldown_timer_timeout")

func _process(delta):
	if can_fire and Input.is_action_just_pressed("fire"):
		var l = laser.instance()
		ship.get_parent().add_child(l)
		l.global_position = global_position
		timer.start()
		can_fire = false

func on_cooldown_timer_timeout():
	can_fire = true
