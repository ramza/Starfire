# HUD
extends CanvasLayer

onready var score_label=get_node("ScoreLabel")
onready var game_over_label=get_node("GameOverLabel")
onready var ready_label=get_node("ReadyLabel");
onready var retry_label=get_node("RetryLabel")
onready var wave_label=get_node("WaveLabel")

var level_manager

# Called when the node enters the scene tree for the first time.
func _ready():
	update_score(Global.score)
	level_manager=get_tree().get_nodes_in_group("LevelManager")[0]
	game_over_label.hide()
	retry_label.hide()
	retry_label.text="TRY AGAIN? "+str(Global.current_lives)+" Ships\nPress Enter"
	update_wave_label()

func update_wave_label():
	wave_label.text="WAVE: "+str(Global.current_wave)
	
func update_score(value):
	Global.score+=value
	score_label.text="Score: "+str(Global.score)
	
func game_over():
	if Global.current_lives >= 0:
		retry_label.show()
	else:
		game_over_label.show()
	Global.game_over=true
	
func hide_ready_label():
	ready_label.hide()
	
func show_ready_label():
	ready_label.show()
	
