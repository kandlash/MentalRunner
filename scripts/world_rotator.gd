extends Area3D

@export
var rotate_degree = -90

@export
var world_point : Node3D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node3D) -> void:
	if body.name != "player":
		return
	var tween = create_tween()
	tween.tween_property(
		world_point,
		"rotation",
		Vector3(0, 0, deg_to_rad(rotate_degree)),
		0.6
	)
	#world_point.rotate_z(deg_to_rad(rotate_degree))
