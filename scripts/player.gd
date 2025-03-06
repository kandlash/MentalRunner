extends CharacterBody3D

var default_speed = 30


var main_speed = default_speed

const LANE_CHANGE_TIME = 0.3

var mouse_sensitivity = 0.002
var current_position = 1
var target_x = current_position
var position_coords = [5, 0, -5]
@onready var camera_3d: Camera3D = $head/Camera3D
@onready var ray_cast_3d: RayCast3D = $RayCast3D
@onready var raycast: RayCast3D = $RayCast3D2

var crouch_height = 1.0
var crouch_radius = 0.25
var crouch_collision_y = 0.5
var crouch_head_y = 0.8

var stand_height = 2.0
var stand_radius = 0.5
var stand_collision_y = 1.0
var stand_head_y = 1.644
var is_crouch = false
var is_wall_running = false

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _input(event):
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:

		$head.rotate_y(-event.relative.x * mouse_sensitivity)
		$head.rotation.y = clampf($head.rotation.y, -deg_to_rad(1), deg_to_rad(90))
		camera_3d.rotate_x(-event.relative.y * mouse_sensitivity)
		camera_3d.rotation.x =  clampf(camera_3d.rotation.x, -deg_to_rad(35), deg_to_rad(35))
	if Input.is_action_just_pressed("debug_camera_change"):
		if !$head/Camera3D.current:
			$head/Camera3D.make_current()
		else:
			$head2/Camera3D.make_current()
	
	if Input.is_action_just_pressed("reload"):
		get_tree().reload_current_scene()
		
func _physics_process(delta: float) -> void:
	if not is_on_floor() and !is_wall_running:
		velocity += get_gravity() * delta
	else:
		velocity.y = 0

	if raycast.is_colliding() and not is_on_floor():
		var floor_height = raycast.get_collision_point().y
		position.y = floor_height
		velocity.y = 0 
	
	handle_crouch()

	target_x = position_coords[current_position]
	if Input.is_action_just_pressed("left") and !is_crouch and !is_wall_running:
		current_position = clamp(current_position - 1, 0, len(position_coords) - 1)
		target_x = position_coords[current_position]
	if Input.is_action_just_pressed("right") and !is_crouch and !is_wall_running:
		current_position = clamp(current_position + 1, 0, len(position_coords) - 1)
		target_x = position_coords[current_position]
	
	if !is_wall_running: position.x = lerp(position.x, float(target_x), LANE_CHANGE_TIME)

	velocity.z = main_speed
	$head/AnimationPlayer.play("camera_bob")
	if !is_crouch:
		$head/AnimationPlayer.play("camera_bob")
	else:
		$head/AnimationPlayer.stop()

	move_and_slide()
	var n = $RayCast3D.get_collision_normal()
	var xform = align_with_y(global_transform, n)
	global_transform = global_transform.interpolate_with(xform, 0.2)

func align_with_y(xform, new_y):
	xform.basis.y = new_y
	xform.basis.x = -xform.basis.z.cross(new_y)
	xform.basis = xform.basis.orthonormalized()
	return xform

func handle_crouch():
	if Input.is_action_pressed("crouch"):
		$CollisionShape3D.shape.height = crouch_height
		$CollisionShape3D.shape.radius = crouch_radius
		$CollisionShape3D.position.y = crouch_collision_y
		$head.position.y = crouch_head_y
		is_crouch = true
	else:
		$CollisionShape3D.shape.height = stand_height
		$CollisionShape3D.shape.radius = stand_radius
		$CollisionShape3D.position.y = stand_collision_y
		$head.position.y = stand_head_y
		is_crouch = false
