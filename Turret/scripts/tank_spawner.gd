extends Path2D


@onready var tank = preload("res://scenes/standard_tank.tscn")
@onready var spawn_point = $TankSpawnPoint
@export var time_between_spawns = 3.0 
@onready var timer = $SpawnTimer



func _ready():
	# Set timer wait time 
	timer.wait_time = time_between_spawns
	

# Got code from Rockets
func _spawn_missle():
	var new_tank = tank.instantiate()
	# Get location from path 
	spawn_point.progress_ratio = randf()
	# Set tank position to path position 
	new_tank.global_position = spawn_point.global_position
	# Add tank to scene 
	add_child(new_tank)
	
func _on_timer_timeout():
	# Spawn missle when time runs out 
	_spawn_missle()
