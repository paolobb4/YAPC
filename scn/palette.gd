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


func _ready():
	#TODO: change sprite if ai?
	screensize = get_viewport_rect().size
	randomize()


func _process(delta):
	if ai:
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
	if (ball.position.x > screensize.x / ai_sight) and ball.direction.x > 0:
		if wait_time <= -ai_recover and randf() < (ai_miss_chance / 100):
			wait_time = ai_hold
		if wait_time <= 0:
			if ball.position.y > position.y + 8:
				direction = +1
			elif ball.position.y < position.y - 8:
				direction = -1
			else:
				direction = 0

		wait_time -= delta

		position.y += direction * speed * delta
