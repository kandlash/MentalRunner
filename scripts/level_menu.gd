extends Node3D

var is_menu_open = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("escape"):
		if is_menu_open:
			close_menu()
		else:
			open_menu()

func open_menu() -> void:
	Engine.time_scale = 0.005
	is_menu_open = true
	pause_game()

func close_menu() -> void:
	Engine.time_scale = 1.0
	is_menu_open = false
	resume_game()

func pause_game(is_win=false) -> void:
	$in_game_ui.menu_player.play("menu_out")
	if !is_win:
		$music.stream_paused = true
		$in_game_ui.menu.visible = true
	else:
		$music.volume_db = $music.volume_db * 2.7
		$in_game_ui.win_menu.visible = true
		Engine.time_scale = 0.005
		set_process(false)
		
	$player.set_process(false)
	$player.set_physics_process(false)
	if $player.can_use_katana:
		$player.katana_arm.set_process(false)
	$player.set_process_input(false)
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func resume_game() -> void:
	$in_game_ui.menu_player.play("menu_out")
	$in_game_ui.menu.visible = false
	$music.stream_paused = false
	$player.set_process(true)
	if $player.can_use_katana:
		$player.katana_arm.set_process(true)
	$player.set_physics_process(true)
	$player.set_process_input(true)
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
