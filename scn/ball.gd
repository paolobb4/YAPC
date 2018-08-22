extends Area2D


signal point_scored(side)

var direction = Vector2(-1, 0)
export (int) var init_speed = 180
var init_pitch = 1
var match_speed
var speed
var screensize


func _ready():
	screensize = get_viewport_rect().size
	match_speed = init_speed
	speed = match_speed

func reset(side, speed_factor):
	var dir
	if side == 'left':
		dir = -1
	elif side == 'right':
		dir = 1

	position = screensize / 2
	match_speed += init_speed * speed_factor
	speed = match_speed
	direction = Vector2(dir, 0)

	$Audio/bounce.pitch_scale = speed / init_speed

func _physics_process(delta):
	position += direction * speed * delta

	if position.x < 0:
		emit_signal("point_scored", "right")

	elif position.x > screensize.x:
		emit_signal("point_scored", "left")

	elif position.y < 0 or position.y > screensize.y:
		direction.y *= -1
		position.y = clamp(position.y, 0, screensize.y)
		$Audio/bounce.play()


func _on_Ball_body_entered(body):
	# diff(y1, y2) / [(len(palette)+len(ball)) / 2] = angle; -1 <= angle <= 1
	var abs_angle = (body.position.y - self.position.y) / (16 + 4)
	if abs(abs_angle) > 1:
		return

	var bounce_angle = abs_angle * deg2rad(65)	# limit bouncing angle to 75°

	var side = 1 if body.position.x < screensize.x/2 else -1

	direction = Vector2(side*cos(bounce_angle), -sin(bounce_angle))	# Linear Algebra, yoh!

	$Audio/bounce.play()

	speed *= 1.02
	$Audio/bounce.pitch_scale = 1 + speed / (20 * init_speed)
