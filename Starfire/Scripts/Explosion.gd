# EXPLOSION
extends Node2D

onready var anim = get_node("AnimationPlayer")

func _ready():
	anim.connect("animation_finished",self,"on_animation_finished")

func on_animation_finished(cur_anim):
	queue_free()
