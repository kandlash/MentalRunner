extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node3D) -> void:
	if body.name == "player":
		print('change gravity')
		ProjectSettings.set_setting("physics/2d/default_gravity", -980*10)

func _on_body_exited(body: Node3D) -> void:
	if body.name == "player":
		print('reset gravity')
		ProjectSettings.set_setting("physics/2d/default_gravity", -980)
