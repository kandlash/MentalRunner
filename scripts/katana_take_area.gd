extends Area3D


func _on_body_entered(body: Node3D) -> void:
	if body.name == "player":
		body.allow_katana()
		$AudioStreamPlayer.play()
		
