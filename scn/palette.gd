extends KinematicBody2D

export (bool) var AI = false
export (int) var speed = 150

var screensize
var wait_time = 0	# used to create ai's handicap
var direction = 0


func _ready():
	#TODO: change sprite if ai?
	screensize = get_viewport_rect().size
	randomize()


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
	var ball = get_owner().get_node("Ball")
	if (ball.position.x > screensize.x / 3) and ball.direction.x > 0:
		if wait_time <= -1 and randf() < .15:
			wait_time = .3
		if wait_time <= 0:
			if ball.position.y > position.y + 8:
				direction = +1
			elif ball.position.y < position.y - 8:
				direction = -1
			else:
				direction = 0

		wait_time -= delta

		position.y += direction * speed * delta
