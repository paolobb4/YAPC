extends KinematicBody2D

export (int)		var speed = 150
export (bool)		var ai = false
export (int)		var ai_sight = 3
export (int, 1, 100)	var ai_miss_chance = 15
export (float)		var ai_hold = .3
export (float)		var ai_recover = 1

var screensize
var wait_time = 0	# used to create ai's handicap
var direction = 0

var size = Vector2(8, 32)

func _ready():
	#TODO: change sprite if ai?
	screensize = get_viewport_rect().size
	randomize()
	if self.position.x > screensize.x / 2:
		$Sprite.region_rect.position.x = size.x


func _process(delta):
	if ai:
		ai_process(delta)
	else:
		player_process(delta)

	if position.y < 0 or position.y > screensize.y:
		position.y = clamp(position.y, 0, screensize.y)

	if position.y - size.y/2 < 0:
		position.y = size.y/2
	if position.y + size.y/2 > screensize.y:
		position.y = screensize.y - size.y/2


func player_process(delta):
	direction = 0
	# player 1
	if position.x < screensize.x / 2:
		if Input.is_action_pressed("p1_up"):
			direction -= 1
		if Input.is_action_pressed("p1_down"):
			direction += 1
	# player 2
	else:
		if Input.is_action_pressed("p2_up"):
			direction -= 1
		if Input.is_action_pressed("p2_down"):
			direction += 1

	position.y += direction * speed * delta


func ai_process(delta):
	var ball = get_owner().get_node("Ball")
	var ball_within_sight
	var ball_comming

	# player 1
	if position.x < screensize.x / 2:
		ball_within_sight = ball.position.x < screensize.x - (screensize.x / ai_sight)
		ball_comming = ball.direction.x < 0
	# player 2
	else:
		ball_within_sight = ball.position.x > screensize.x / ai_sight
		ball_comming = ball.direction.x > 0

	if ball_within_sight and ball_comming:
		if wait_time <= -ai_recover and randf() < (ai_miss_chance / 100) or wait_time < -5:
			wait_time = ai_hold
		if wait_time <= 0:
			if ball.position.y > position.y + 4:
				direction = +1
			elif ball.position.y < position.y - 4:
				direction = -1
			else:
				direction = 0

		wait_time -= delta

		position.y += direction * speed * delta
