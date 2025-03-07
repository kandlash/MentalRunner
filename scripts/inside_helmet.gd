extends Node3D

var mouse_sensitivity = 0.002

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event):
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * mouse_sensitivity)
		$Camera3D.rotate_x(-event.relative.y * mouse_sensitivity)
		$Camera3D.rotation.x = clampf($Camera3D.rotation.x, -deg_to_rad(35), deg_to_rad(35))


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "boot":
		$levels.visible = true
		var tween = create_tween()
		tween.tween_property($levels, "position", Vector3.ZERO, 0.3).set_trans(Tween.TRANS_SPRING)
		tween.tween_callback(level_end_anim)
		$Control/Label.visible = true
		$Control/Label2.visible = true
		
func level_end_anim():
	$levels.set_process(true)
