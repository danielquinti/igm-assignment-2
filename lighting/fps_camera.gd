extends Camera3D

var is_fps_camera: bool = true 

@export var move_speed: float = 5.0
@export var mouse_sensitivity: float = 0.003

func _input(event: InputEvent) -> void:
	if current and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			rotation.y -= event.relative.x * mouse_sensitivity
			rotation.x -= event.relative.y * mouse_sensitivity
			rotation.x = clamp(rotation.x, -PI/2, PI/2)

func _process(delta: float) -> void:
	if not current:
		return
		
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		position += direction * move_speed * delta
