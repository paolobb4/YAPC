extends KinematicBody2D

export (bool) var AI = false
export (int) var speed = 150

var screensize
var tp = 0	# time passed
var direction = 0


func _ready():
	#TODO: change sprite if ai?
	screensize = get_viewport_rect().size


func _process(delta):
	if AI:
		ai_process(delta)
	else:
		player_process(delta)

	if position.y < 0 or position.y > screensize.y:
		position.y = clamp(position.y, 0, screensize.y)


func player_process(delta):
	direction = 0
	if Input.is_action_pressed("ui_up"):
		direction -= 1
	if Input.is_action_pressed("ui_down"):
		direction += 1

	position.y += direction * speed * delta


func ai_process(delta):
	#TODO: implement ai
	var ball = get_owner().get_node("Ball")
	if ball.position.x > screensize.x / 2:
		tp += delta
		if tp > 1:
			tp -= 1

		if tp >= .1:
			if ball.position.y > position.y:
				direction = +1
			elif ball.position.y < position.y:
				direction = -1

		position.y += direction * speed * delta
	else:
		tp = .1
