extends Sprite2D

# Crosshair icon 
@onready var crosshair:TextureRect = %Cursor
# Less than 0.1 is best. 
const TRAVERSE:float = 0.05
# Bullet scene 
const BULLET: PackedScene = preload("res://scenes/bullet.tscn")
# How long the cannon takes to reload
const RELOAD_TIME: float = 0.5

@onready var reload_timer = %ReloadTimer
var can_fire: bool = true

func _ready():
	reload_timer.wait_time = RELOAD_TIME

func _process(delta):
	look_at_crosshair()
	
func _unhandled_input(event):
	if can_fire and Input.is_action_pressed("shoot"):
		shoot()

func look_at_crosshair():
	var angle_to_crosshair := global_position.angle_to_point(crosshair.global_position) + PI/2
	var distance_to_rotate = lerp_angle(global_rotation, angle_to_crosshair,TRAVERSE)
	global_rotation = distance_to_rotate
	
# Used this video (around 1:35:00)
# https://www.youtube.com/watch?v=GwCiGixlqiU&t=7222s
func shoot():
	# Spawn bullet 
	var new_bullet = BULLET.instantiate()
	# Set bullet position and rotation 
	new_bullet.global_position = %FiringPoint.global_position
	new_bullet.global_rotation = %FiringPoint.global_rotation
	# Add bullet to scene 
	%FiringPoint.add_child(new_bullet)
	# Start reload timer
	reload_timer.start()
	# Prevent the cannon from firing while reloading
	can_fire = false
	

func _on_reload_timer_timeout():
	# Enable the cannon to shoot again.
	can_fire = true
