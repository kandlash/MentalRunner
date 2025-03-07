extends Camera3D

var mouse_sensitivity = 0.0005
@onready var ray_cast_3d: RayCast3D = $RayCast3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
var start_transform
var can_click = true
@onready var camera_3d_2: Camera3D = $"../Camera3D2"
@onready var audio_stream_player_3d: AudioStreamPlayer = $AudioStreamPlayer3D
@export var audios: Array[AudioStream]
var current_audio = 4
@onready var first_garbage: Node3D = $"../first_garbage"
@onready var second_garbage: Node3D = $"../second_garbage"

# Флаги для отслеживания состояния игрока
var has_drunk: bool = false
var has_slept: bool = false

func _ready():
	start_transform = transform
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event):
	if animation_player.is_playing():
		return
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * mouse_sensitivity)
		rotation.y = clampf(rotation.y, deg_to_rad(45), deg_to_rad(170))
		rotate_z(-event.relative.y * mouse_sensitivity)
		rotation.z =  clampf(rotation.z, -deg_to_rad(10), deg_to_rad(12))
		rotation.x =  clampf(rotation.x, -deg_to_rad(50), deg_to_rad(20))

func _process(delta: float) -> void:
	if animation_player.is_playing():
		return

	if ray_cast_3d.is_colliding() and can_click:
		handle_collision()
	else:
		clear_ui_label()

func handle_collision() -> void:
	var collider = ray_cast_3d.get_collider()

	if collider.is_in_group("drink"):
		if has_drunk:
			update_ui_label("I need to sleep...")
		else:
			update_ui_label("[LEFT CLICK] - Drink")
			handle_drink_input(collider)
	elif collider.is_in_group("sleep"):
		if has_drunk and not has_slept:
			update_ui_label("[LEFT CLICK] - Sleep")
			handle_sleep_input(collider)
		else:
			update_ui_label("I need to drink...")
	elif collider.is_in_group("helmet"):
		update_ui_label("[LEFT CLICK] - Put on a helmet")
		handle_helmet_input(collider)

func play_audio():
	if current_audio < audios.size():
		$AudioStreamPlayer3D.stream = audios[current_audio]
		$AudioStreamPlayer3D.play()
		current_audio = current_audio + 1

func handle_drink_input(collider: Object) -> void:
	if Input.is_action_just_pressed("attack"):
		var tween = create_tween()
		tween.tween_property(self, "transform", start_transform, 0.15)
		tween.tween_callback(start_drink)
		play_audio()

func handle_sleep_input(collider: Object) -> void:
	if Input.is_action_just_pressed("attack"):
		var tween = create_tween()
		tween.tween_property(self, "transform", camera_3d_2.transform, 1.5)
		tween.tween_callback(set_camera2_current)
		play_audio()

func handle_helmet_input(collider: Object) -> void:
	if Input.is_action_just_pressed("attack"):
		var tween = create_tween()
		tween.tween_property(self, "transform", start_transform, 0.15)
		tween.tween_callback(start_helmet_anim)
		play_audio()

func start_helmet_anim():
	animation_player.play("helmet_on_animation")

func update_ui_label(text: String) -> void:
	$"../ui/Label".text = text

func clear_ui_label() -> void:
	$"../ui/Label".text = ""

func start_drink():
	animation_player.play("drink_animation")
	has_drunk = true  # Игрок выпил

func set_camera2_current():
	current = false
	transform = start_transform
	camera_3d_2.make_current()
	set_process_input(false)
	$"../Camera3D2/bed_animation_player".play("sleep_animation")
	has_slept = true  # Игрок поспал

func _on_click_cooldown_timeout() -> void:
	can_click = true

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "drink_animation":
		$click_cooldown.start()
		can_click = false

func _on_bed_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "sleep_animation":
		set_process_input(true)
		camera_3d_2.current = false
		make_current()
		$"../Camera3D2/bed_animation_player".play("RESET")
		has_drunk = false  # Сброс состояния после сна
		has_slept = false  # Сброс состояния после сна
		first_garbage.visible = true
		if current_audio >= 3:
			second_garbage.visible = true
		if current_audio >=5:
			first_garbage.visible = false
			second_garbage.visible = false
			$"../helmet".visible = true
			$"../helmet/StaticBody3D/CollisionShape3D".disabled = false
			$"../drink_collider".queue_free()
			$"../Drinks".queue_free()


func _on_audio_stream_player_3d_finished() -> void:
	if current_audio == 7:
		pass
