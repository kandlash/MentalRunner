extends Camera3D

@onready var ray_cast_3d: RayCast3D = $RayCast3D
@onready var player: CharacterBody3D = $"../.."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("hook"):
		if !ray_cast_3d.is_colliding(): return
		if !ray_cast_3d.get_collider().is_in_group("side_platform_hook"): return
		
		var side_platform_hook = ray_cast_3d.get_collider()
		var side_platform_point = side_platform_hook.get_parent().get_node("point")
		side_platform_hook.queue_free()
		player.is_wall_running = true
		
		var tween = create_tween()
		tween.tween_property(
			player,
			"global_position",
			side_platform_point.global_position,
			0.3
		)
		
