extends Area3D

var mesh_slicer = MeshSlicer.new()
var chance_to_slowmotion = 40

func start_slow_motion(scale: float = 0.5) -> void:
	Engine.time_scale = scale

# Run the game at normal speed.
func stop_slow_motion() -> void:
	Engine.time_scale = 1.0

func take_damage(slicer):
	$Blood.restart()
	$AudioStreamPlayer3D.play()
	$CollisionShape3D.disabled = true
	if randi_range(0, 100) <= chance_to_slowmotion:
		start_slow_motion(0.1)
		$SlowMotionTimer.start()
	add_child(mesh_slicer)
	var Transform = slicer.global_transform
	var MeshInstance = $MeshInstance3D
	
	Transform.origin = $MeshInstance3D.to_local(Transform.origin)
	Transform.basis.x =  $MeshInstance3D.to_local(Transform.basis.x+MeshInstance.global_position)
	Transform.basis.y =  $MeshInstance3D.to_local(Transform.basis.y+MeshInstance.global_position)
	Transform.basis.z =  $MeshInstance3D.to_local(Transform.basis.z+MeshInstance.global_position)
	var meshes = mesh_slicer.slice_mesh(Transform, MeshInstance.mesh)
	MeshInstance.queue_free()
	
	# Создаем RigidBody3D для каждой части меша
	for i in range(meshes.size()):
		var new_mesh_instance = MeshInstance3D.new()
		new_mesh_instance.mesh = meshes[i]
		
		var rigid_body = RigidBody3D.new()
		rigid_body.add_child(new_mesh_instance)
		rigid_body.position += Vector3(randf_range(0.05, 0.1), randf_range(0.05, 0.1), randf_range(0.05, 0.1))
		rigid_body.collision_layer = 4  
		rigid_body.collision_mask = 2
		
		var collision_shape = CollisionShape3D.new()
		collision_shape.shape = meshes[i].create_convex_shape()
		rigid_body.add_child(collision_shape)
		
		# Добавляем RigidBody3D на сцену
		add_child(rigid_body)
		var impulse_strength = 10.0  # Сила импульса
		var direction = Vector3(0, 1, -1)
		rigid_body.apply_central_impulse(direction * impulse_strength)
	

func _on_body_entered(body: Node3D) -> void:
	if body.name == "player":
		get_tree().reload_current_scene()


func _on_slow_motion_timer_timeout() -> void:
	stop_slow_motion()
