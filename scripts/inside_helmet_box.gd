extends CSGBox3D

var speed
var rand_scale
var start_position

func _ready() -> void:
	random_props()
	start_position = position

func random_props():
	rand_scale = randf_range(0.3, 1.2)
	speed = randf_range(0.5, 1)
	scale = Vector3(rand_scale,rand_scale,rand_scale)

func _process(delta: float) -> void:
	position.y -= speed * delta
	if position.y <= -5:
		position = start_position
		random_props()
