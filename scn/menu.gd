extends Node2D


func _ready():
	get_tree().paused = true


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
