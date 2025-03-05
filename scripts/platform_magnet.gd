extends Area3D

@onready var ray_cast_3d: RayCast3D = $RayCast3D


func _on_body_entered(body: Node3D) -> void:
	if ray_cast_3d.is_colliding():
		var floor_height = ray_cast_3d.get_collision_point().y
		var angle = ray_cast_3d.get_collider().get_parent().rotation.x
		var tween2 = create_tween()
		tween2.tween_property(
			body,
			"rotation",
			Vector3(angle, body.rotation.y, body.rotation.z),
			0.2
		)
		var tween = create_tween()
		body.velocity = Vector3.ZERO
		print('hello')
		tween.tween_property(
			body,
			"position",
			Vector3(body.position.x, floor_height, body.position.z),
			0.2
		)
		tween.tween_callback(zero_vel.bind(body))
		
func zero_vel(body):
	body.velocity = Vector3.ZERO
	print(body.velocity)
