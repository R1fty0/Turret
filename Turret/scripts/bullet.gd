extends Area2D

const SPEED: float = 10

	
func _physics_process(delta):
	move(delta)
	
func move(delta):
	var distance = Vector2(0, 1).rotated(rotation) * SPEED
	var velocity = distance * delta
	position += velocity
