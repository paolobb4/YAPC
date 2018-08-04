extends Node


signal paused


func _ready():
	pause(false)


func _process(delta):
	if Input.is_action_just_pressed('ui_cancel'):
		pause()


func _on_point_scored(side):
	if side == "left":
		$score_left.text = str(int($score_left.text) + 1)
	if side == "right":
		$score_right.text = str(int($score_right.text) + 1)


func pause(sound=true):
	emit_signal('paused')
	get_tree().paused = true
	if sound:
		$Audio/pause_in.play()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func unpause(sound=true):
	get_tree().paused = false
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
