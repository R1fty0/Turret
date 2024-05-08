extends Sprite2D

@onready var crosshair = %Crosshair
# Less than 0.1 is best. 
const TRAVERSE = 0.05
# Bullet scene 
const BULLET = preload("res://scenes/bullet.tscn")
# Where the bullet will spawn 
@onready var bullet_spawn_point = $"../BulletSpawnPoint"

func _ready():
	pass

func _process(delta):
	look_at_crosshair()

func look_at_crosshair():
	var angle_to_crosshair := global_position.angle_to_point(crosshair.global_position) + PI/2
	var distance_to_rotate = lerp_angle(global_rotation, angle_to_crosshair,TRAVERSE)
	global_rotation = distance_to_rotate
