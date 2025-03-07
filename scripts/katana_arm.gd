extends Node3D

var can_attack = true
@onready var slicer: MeshInstance3D = $Slicer

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("attack") and can_attack:
		$"../../../AnimationPlayer".play("katana_attack_1")
		$"../slash".play_animation()
		$"../../../katana_attack".play()
		$"../attack_area".monitoring = true
		can_attack = false

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "katana_attack_1":
		$"../attack_area".monitoring = false
		can_attack = true


func _on_attack_area_area_entered(area: Area3D) -> void:
	if area.is_in_group("enemy"):
		area.take_damage(slicer)
