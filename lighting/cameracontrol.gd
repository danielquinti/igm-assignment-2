extends Node

@export var cameras: Array[Camera3D]
@export var lights: Array[Light3D]
@export var world_environment: WorldEnvironment 

var current_camera_index: int = 0

func _ready() -> void:
	if cameras.size() > 0:
		activate_camera(0)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("switch_camera"):
		cycle_cameras()
		
	if Input.is_action_just_pressed("toggle_light_1"):
		toggle_light(0)
	if Input.is_action_just_pressed("toggle_light_2"):
		toggle_light(1)
	if Input.is_action_just_pressed("toggle_light_3"):
		toggle_light(2)
		
	if Input.is_action_just_pressed("toggle_ao"):
		toggle_ambient_occlusion()
	if Input.is_action_just_pressed("toggle_sky"):
		toggle_sky()

func cycle_cameras() -> void:
	if cameras.is_empty():
		return
		
	current_camera_index += 1
	if current_camera_index >= cameras.size():
		current_camera_index = 0
		
	activate_camera(current_camera_index)

func activate_camera(index: int) -> void:
	var active_cam = cameras[index]
	active_cam.make_current()
	
	if active_cam.get("is_fps_camera"):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	else:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func toggle_light(index: int) -> void:
	if index < lights.size() and lights[index] != null:
		lights[index].visible = !lights[index].visible

func toggle_ambient_occlusion() -> void:
	if world_environment and world_environment.environment:
		var env = world_environment.environment
		env.ssao_enabled = !env.ssao_enabled

func toggle_sky() -> void:
	if world_environment and world_environment.environment:
		var env = world_environment.environment
		
		if env.background_mode == Environment.BG_SKY:
			env.background_mode = Environment.BG_COLOR
			env.background_color = Color(0, 0, 0)
		else:
			env.background_mode = Environment.BG_SKY
