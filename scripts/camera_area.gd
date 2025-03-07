extends Area3D

@export var camera: Camera3D
@export var point: Node3D



func _on_body_entered(body: Node3D) -> void:
	if body.name == "player":
		camera = body.camera3d
		switch_camera_to_point()

func switch_camera_to_point() -> void:
	if camera and point:
		camera.look_at(point.global_transform.origin)
