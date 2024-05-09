extends Area2D

@export var data: TankBulletData
@onready var sprite = $Sprite

func _ready():
	# Set bullet sprite
	sprite.texture = data.bullet_sprite

func _process(delta):
	move(delta)
	
# Same movement code as normal bullet (except using Vector2.UP instead of Vector2.DOWN)
func move(delta):
	var direction = Vector2.UP.rotated(rotation)
	var velocity = direction * data.bullet_speed * delta
	position += velocity
