extends TextureRect

@export var cursor_data: CursorData


func _ready():
	# Hide the cursor - https://www.youtube.com/watch?v=XXHEhVzInpQ
	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_HIDDEN)

func _process(delta):
	# Update crosshair position to represent mouse position 
	var mouse_position = get_global_mouse_position()
	position = mouse_position
	# Update crosshair to match game state 
	set_cursor()
		
func set_cursor():
	match GameManager.current_mode:
		GameManager.Mode.Building:
			texture = cursor_data.building_cursor
		GameManager.Mode.Collecting:
			texture = cursor_data.collecting_cursor
		GameManager.Mode.Shooting:
			texture = cursor_data.shooting_cursor			
