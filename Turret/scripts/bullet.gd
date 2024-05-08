extends Area2D

const SPEED: float = 1000

	
func _physics_process(delta):
	move(delta)
	
func move(delta):
	var direction = Vector2.DOWN.rotated(rotation)
	var velocity = direction * SPEED * delta
	position += velocity
