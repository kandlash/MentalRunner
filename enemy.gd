extends Area3D

func take_damage():
	queue_free()


func _on_body_entered(body: Node3D) -> void:
	if body.name == "player":
		get_tree().reload_current_scene()
