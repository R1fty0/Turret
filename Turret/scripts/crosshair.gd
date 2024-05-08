extends TextureRect

@export var cursor_data: CursorData


func _ready():
	# Hide the cursor - https://www.youtube.com/watch?v=XXHEhVzInpQ
	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_HIDDEN)

func _process(delta):
	# Update crosshair position to represent mouse position 
	var mouse_position = get_global_mouse_position()
	position = mouse_position
	
