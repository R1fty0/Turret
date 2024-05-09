extends CharacterBody2D

# Public variables
@export var data: StandardTankData 

# References
@onready var hull_sprite = $Hull
@onready var gun_sprite = $Gun
@onready var player = get_node("/root/Game/Player") 
@onready var gun_range_collider = $GunRange/CollisionShape2D
@onready var gun_range_area = $GunRange
@onready var firing_point = $Gun/FiringPoint
@onready var reload_timer = $ReloadTimer
const BULLET: PackedScene = preload("res://scenes/tank_bullet.tscn")

# Tank's current target
var target
# Tank's current state
var current_state: State = State.Moving
# Control whether the Tank can fire
var can_fire: bool = false 

enum State
{
	Moving,
	Firing,
}

func _ready():
	# Set hull and gun sprites
	hull_sprite.texture = data.hull_sprite
	gun_sprite.texture = data.gun_sprite
	# Set gun range
	gun_range_collider = data.gun_range
	# Set gun reload time
	reload_timer.wait_time = data.reload_time

func _process(delta):
	match current_state:
		State.Moving:
			if player != null:
				move()
			if is_target_in_range():
				current_state = State.Firing
				can_fire = true
		State.Firing: 
			if target == null:
				current_state = State.Moving
			else:
				shoot()

# Same shooting code as player cannon 
func shoot():
	if can_fire:
		# Spawn bullet 
		var new_bullet = BULLET.instantiate()
		# Set bullet position and rotation 
		new_bullet.global_position = firing_point.global_position
		new_bullet.global_rotation = firing_point.global_rotation
		# Add bullet to scene 
		firing_point.add_child(new_bullet)
		# Start reload timer
		reload_timer.start()
		# Prevent gun from firing while reloading
		can_fire = false
		

# Move tank towards player 
func move():
	# Get direction to player 
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * data.speed
	move_and_slide()

func is_target_in_range() -> bool:
	# Get all areas in range
	var areas_in_range = gun_range_area.get_overlapping_areas()
	# If there are 1 or more areas in range, target the closest one 
	if areas_in_range.size() > 0:
		target = areas_in_range.front()
		return true
	else:
		return false


func _on_reload_timer_timeout():
	can_fire = true
