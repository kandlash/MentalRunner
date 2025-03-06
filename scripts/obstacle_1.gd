extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$obstacle_mesh.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name == "player":
		$obstacle_mesh.visible = true
		var tween = create_tween()
		tween.tween_property(
			$obstacle_mesh,
			"position",
			Vector3($obstacle_mesh.position.x, 0, $obstacle_mesh.position.z),
			0.5
		).set_trans(Tween.TRANS_SPRING)


func _on_death_area_body_entered(body: Node3D) -> void:
	if body.name == "player":
		get_tree().reload_current_scene()
