extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node3D) -> void:
	if body.name == "player":
		var tween = create_tween()
		body.current_position = 1
		tween.tween_property(
			body,
			"global_position",
			Vector3(0, body.position.y, body.position.z),
			0.2
		)
		tween.tween_callback(stop_wall_run.bind(body))
		
func stop_wall_run(body):
	body.is_wall_running = false
