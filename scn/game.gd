extends Node


signal paused


func _ready():
	pass

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

func unpause():
	pass

func set(p1, p2):
	pass
