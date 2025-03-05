extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Stone_big_001.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name == "player":
		$Stone_big_001.visible = true
		var tween = create_tween()
		tween.tween_property(
			$Stone_big_001,
			"position",
			Vector3($Stone_big_001.position.x, 0, $Stone_big_001.position.z),
			0.5
		).set_trans(Tween.TRANS_SPRING)
