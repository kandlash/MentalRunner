extends Sprite3D

@onready var sprite_3d: Sprite3D = $"."


func _on_player_distance_body_entered(body: Node3D) -> void:
	sprite_3d.visible = true
	
