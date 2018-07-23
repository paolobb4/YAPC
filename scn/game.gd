extends Node


signal paused


func _ready():
	pause()

func _process(delta):
	if Input.is_action_just_pressed('ui_cancel'):
		pause()

func _on_point_scored(side):
	if side == "left":
		$score_left.text = str(int($score_left.text) + 1)
	if side == "right":
		$score_right.text = str(int($score_right.text) + 1)

func pause():
	emit_signal('paused')
	get_tree().paused = true

func unpause():
	get_tree().paused = false

func set_p1_ai(ai):
	$Player_1.ai = ai

func set_p2_ai(ai):
	$Player_2.ai = ai

func reset():
	$Ball.position = Vector2(160, 90)
	$Ball.direction = Vector2(-1, 0)
	$Player_1.position.y = 91
	$Player_2.position.y = 90

	$score_left.text = '0'
	$score_right.text = '0'
