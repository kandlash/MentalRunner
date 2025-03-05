extends Node3D


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("attack"):
		$"../../../AnimationPlayer".play("katana_attack_1")
		$"../slash".play_animation()
