extends Control

@onready var menu_player: AnimationPlayer = $menu_player
@onready var menu: Control = $Menu


func _on_con_button_pressed() -> void:
	get_parent().close_menu()


func _on_res_button_pressed() -> void:
	get_parent().close_menu()
	get_tree().reload_current_scene()


func _on_exit_button_pressed() -> void:
	get_parent().close_menu()
	get_tree().change_scene_to_file("res://scenes/inside_helmet.tscn")
