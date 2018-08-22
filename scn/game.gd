extends Node


signal win(pl)
var paused
var points = 5
var speed_factor = 0.03


func _ready():
	pause(false)


func _on_point_scored(side):
	if side == "left":
		$score_left.text = str(int($score_left.text) + 1)
		if int($score_left.text) == points:
			$Audio/win.play()
			emit_signal("win", "1")
			pause(false)
		else:
			$Audio/score.play()
	if side == "right":
		$score_right.text = str(int($score_right.text) + 1)
		if int($score_right.text) == points:
			$Audio/win.play()
			emit_signal("win", "2")
			pause(false)
		else:
			$Audio/score.play()

	$Ball.reset(side, speed_factor)
	$Player_1.reset(speed_factor)
	$Player_2.reset(speed_factor)

	if (randi()%2):
		$Player_1.position.y = 108 - (randi()%2)
		$Player_2.position.y = 109 + (randi()%2)
	else:
		$Player_1.position.y = 109 + (randi()%2)
		$Player_2.position.y = 108 - (randi()%2)


func pause(sound=true):
	get_tree().paused = true # necessary for physics to work
	pause_mode = 1
	paused = true
	if sound:
		$Audio/pause_in.play()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func unpause(sound=true):
	get_tree().paused = false # refer to pause()
	pause_mode = 2
	paused = false
	if sound:
		$Audio/pause_out.play()
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func set_p1_ai(ai):
	$Player_1.ai = ai

func set_p2_ai(ai):
	$Player_2.ai = ai


func reset():
	$Ball._ready()
	$Player_1._ready()
	$Player_2._ready()

	$Ball.position = Vector2(192, 108)
	$Ball.direction = Vector2(-1, 0)
	if (randi()%2):
		$Player_1.position.y = 108 - (randi()%2)
		$Player_2.position.y = 109 + (randi()%2)
	else:
		$Player_1.position.y = 109 + (randi()%2)
		$Player_2.position.y = 108 - (randi()%2)

	$score_left.text = '0'
	$score_right.text = '0'

	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
