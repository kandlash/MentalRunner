extends Area3D

@export var wait_time : float = 1
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
	$Timer.start(wait_time)

func _on_timer_timeout() -> void:
	stop_slow_motion()
