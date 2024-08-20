# TITLE SCREEN
extends Node2D

onready var start_label=get_node("StartLabel")
onready var fx=get_node("FX")
onready var music=get_node("Music")
onready var start_timer=get_node("StartTimer")

var timer=0
var flag=false

# Called when the node enters the scene tree for the first time.
func _ready():
	start_timer.connect("timeout",self,"on_start_timer_timeout")

func on_start_timer_timeout():
	start_timer.stop()
	get_tree().change_scene("res://Scenes/World.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer += delta
	if not flag and timer > 1 and Input.is_action_just_pressed("start"):
		fx.play()
		music.stop()
		flag=true
		start_label.get_node("AnimationPlayer").play("Hide")
		start_timer.start()
