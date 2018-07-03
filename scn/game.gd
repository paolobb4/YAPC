extends Node


func _ready():
	pass

func _on_point_scored(side):
	if side == "left":
		$score_left.text = str(int($score_left.text) + 1)
	if side == "right":
		$score_right.text = str(int($score_right.text) + 1)
