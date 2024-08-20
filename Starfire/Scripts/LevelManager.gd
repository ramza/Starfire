# LEVEL MANAGER
extends Node2D

var enemy_spawner
onready var level_timer = get_node("LevelTimer")
var HUD

func _ready():
	enemy_spawner = get_tree().get_nodes_in_group("EnemySpawner")[0]
	enemy_spawner.lvl_manager=self
	HUD = get_tree().get_nodes_in_group("HUD")[0]
	level_timer.connect("timeout",self,"on_level_timer_timeout")
	level_timer.start()

func on_level_timer_timeout():
	enemy_spawner.enemy_wave()
	level_timer.stop()
	HUD.hide_ready_label()
	
func _process(delta):
	if Global.game_over and Global.current_lives>=0:
		if Input.is_action_just_pressed("start"):
			Global.current_lives-=1
			Global.game_over=false
			get_tree().reload_current_scene()
