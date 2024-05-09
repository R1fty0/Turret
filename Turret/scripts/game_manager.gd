extends Node

@onready var current_mode: Mode = Mode.Shooting 

enum Mode
{
	Building,
	Collecting,
	Shooting
}

func _unhandled_input(event):
	if Input.is_action_pressed("building_mode"):
		current_mode = Mode.Building
	elif Input.is_action_pressed("collecting_mode"):
		current_mode = Mode.Collecting
	elif Input.is_action_pressed("shooting_mode"):
		current_mode = Mode.Shooting
