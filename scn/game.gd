extends Node


var paused


func _ready():
	pause(false)


func _on_point_scored(side):
	if side == "left":
		$score_left.text = str(int($score_left.text) + 1)
	if side == "right":
		$score_right.text = str(int($score_right.text) + 1)


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
	$Ball.position = Vector2(192, 108)
	$Ball.direction = Vector2(-1, 0)
	$Player_1.position.y = 109
	$Player_2.position.y = 108

	$score_left.text = '0'
	$score_right.text = '0'

	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
