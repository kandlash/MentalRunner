extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# This will make the game play at half-speed by default.
func start_slow_motion(scale: float = 0.5) -> void:
	Engine.time_scale = scale

# Run the game at normal speed.
func stop_slow_motion() -> void:
	Engine.time_scale = 1.0

func _on_body_entered(body: Node3D) -> void:
	if body.name != "player":
		return
	start_slow_motion(0.3)
	var start_rotation = body.get_node("head").rotation
	var tween = create_tween()
	tween.tween_property(
		body.get_node("head"),
		"rotation",
		Vector3(0, deg_to_rad(-50), 0),
		0.5
	)
	tween.tween_callback(reset.bind(body, start_rotation))

func reset(body, s_p):
	var tween = create_tween()
	tween.tween_property(
		body.get_node("head"),
		"rotation",
		s_p,
		0.2
	)
	stop_slow_motion()
