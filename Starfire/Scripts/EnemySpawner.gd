# ENEMY SPAWNER
extends Node2D

var crawler=load("res://scenes/Crawler.tscn")
onready var timer=get_node("Timer")

var spawn_count=0
var spawn_point=Vector2()
var living_enemies=0
var lvl_manager

func _ready():
	timer.connect("timeout",self,"on_spawntimer_timeout")
	spawn_point=Vector2(global_position.x,32)

func on_spawntimer_timeout():
	var number_to_spawn=5
	
	for i in range(number_to_spawn):
		var enemy=crawler.instance()
		get_parent().add_child(enemy)
		var pos=Vector2(spawn_point.x,spawn_point.y+(i*24)+8)
		enemy.global_position=pos
		enemy.connect("dead",self,"on_enemy_dead")
		
	living_enemies=number_to_spawn
	timer.stop()
	
func enemy_wave():
	timer.start()
	
func on_enemy_dead():
	living_enemies-=1
	print("enemies left: "+str(living_enemies))
	if(not Global.game_over and living_enemies<=0):
		Global.current_wave+=1
		lvl_manager.HUD.update_wave_label()
		lvl_manager.HUD.show_ready_label()
		lvl_manager.level_timer.start()
		timer.start()
