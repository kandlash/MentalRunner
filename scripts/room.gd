extends Node3D

# Сигнал, который будет вызываться, если клавиша зажата 3 секунды
signal long_press_detected

# Таймер для отслеживания времени зажатия
var press_timer: float = 0.0
# Флаг, чтобы отслеживать, зажата ли клавиша
var is_key_pressed: bool = false

# Ссылка на RadialProgress
@onready var radial_progress: RadialProgress = $ui/Control

func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_accept"):
		if not is_key_pressed:
			is_key_pressed = true
			press_timer = 0.0 
		press_timer += delta
		
		# Обновляем прогресс-бар
		radial_progress.progress = (press_timer / 1.0) * radial_progress.max_value
		
		# Если таймер достиг 1.5 секунд
		if press_timer >= 1.0:
			get_tree().change_scene_to_file("res://scenes/inside_helmet.tscn")
			reset()  # Сбрасываем состояние
	else:
		# Клавиша отпущена
		reset()

# Сброс состояния
func reset() -> void:
	is_key_pressed = false
	press_timer = 0.0
	radial_progress.progress = 0.0  # Сбрасываем прогресс-бар
