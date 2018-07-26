extends Node2D


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
		$Audio/menu_button.play()
