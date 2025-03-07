extends Node3D

var current_level: int = 0
@onready var tween: Tween = create_tween()  # Создаем твин
var can_change = true

@export var levels_array: Array[String]

func _ready() -> void:
	set_process(false)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("accept"):
		get_tree().change_scene_to_file(levels_array[current_level])
		
	if !can_change:
		return
	if Input.is_action_just_pressed("left") and current_level > 0:
		move_smoothly(4)  # Плавное перемещение вправо
		current_level -= 1
	elif Input.is_action_just_pressed("right") and current_level < 2:
		move_smoothly(-4)  # Плавное перемещение влево
		current_level += 1

func move_smoothly(amount: float) -> void:
	can_change = false
	# Задаем новую цель для позиции X
	var target_x = position.x + amount
	# Создаем плавное перемещение
	tween = create_tween()
	tween.tween_property(self, "position:x", target_x, 0.25)  # 0.5 — длительность анимации в секундах
	tween.set_ease(Tween.EASE_IN_OUT)  # Плавное ускорение и замедление
	tween.set_trans(Tween.TRANS_SINE)  # Тип анимации (можно выбрать другой)
	tween.tween_callback(reset_)

func reset_():
	can_change = true
