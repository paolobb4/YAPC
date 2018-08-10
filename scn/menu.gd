extends Node2D


func _ready():
	get_tree().paused = true
	AudioServer.set_bus_volume_db(0, -20)


func _process(delta):
	if self.position.x == -768:	# i.e. when playing
		if Input.is_action_just_pressed('ui_cancel'):
			if $Game.paused:
				$Game.unpause()
				$'Pause Panel'.hide()
			else:
				$Game.pause()
				$'Pause Panel'.show()


func _on_quit_Button_pressed():
	get_tree().quit()


func _on_full_screen_pressed():
	OS.window_fullscreen = !OS.window_fullscreen


func _on_volume_changed(db):
	if db == -50:
		AudioServer.set_bus_mute(0, true)
	else:
		AudioServer.set_bus_mute(0, false)
		AudioServer.set_bus_volume_db(0, db)
		$'Audio/menu button'.play()

func _on_decrease_Button_pressed():
	# cn = cn + max - max
	# cn = max - max + cn
	# cn = max - (max - cn)
	# => cn - 1 = max - (max - (cn - 1))
	#    cn - 1 = max - (max - cn + 1)
	# => max - (max - cn + 1) % max    will loop back to max skipping 0.

	var points = $"Play Game/points/value"
	points.text = str(99 - ((99 - int(points.text) + 1) % 99))
	$Game.points = int(points.text)


func _on_increase_Button_pressed():
	var points = $"Play Game/points/value"
	points.text = str((int(points.text) + 1) % 99)
	$Game.points = int(points.text)


func _on_Game_win(pl):
	$"Win Panel/number".text = pl
	if pl == '1':
		$"Win Panel".get("custom_styles/panel").bg_color = Color("5ee4df")
	else:
		$"Win Panel".get("custom_styles/panel").bg_color = Color("ee8adc")

	$"Win Panel".show()
