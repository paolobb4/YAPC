extends Area2D


signal point_scored(side)

var direction = Vector2(-1, 0)
export (int) var speed = 100
var screensize


func _ready():
	screensize = get_viewport_rect().size


func _physics_process(delta):
	position += direction * speed * delta
	if position.x < 0:
		position = screensize / 2
		direction = Vector2(1, 0)
		emit_signal("point_scored", "right")

	if position.x > screensize.x:
		position = screensize / 2
		direction = Vector2(-1, 0)
		emit_signal("point_scored", "left")

	if position.y < 0 or position.y > screensize.y:
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
