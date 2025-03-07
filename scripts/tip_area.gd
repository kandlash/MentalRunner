extends Area3D

@export var label : Label
@export var tip_time : float = 3
@export var tip_text : String = "[] to"

func _on_body_entered(body: Node3D) -> void:
	if body.name == "player":
		label.visible = true
		label.text = tip_text
		$Timer.start(tip_time)


func _on_timer_timeout() -> void:
		label.visible = false
		label.text = ""
