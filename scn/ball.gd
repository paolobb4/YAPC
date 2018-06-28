extends Area2D


var direction = Vector2(-1, 0).normalized()
export (int) var speed = 100
var screensize


func _ready():
	screensize = get_viewport_rect().size


func _process(delta):
	position += direction * speed * delta
	# TODO: replace x collision with point score
	if position.x < 0:
		position = screensize / 2
		direction = Vector2(1, 0)
	if position.x > screensize.x:
		position = screensize / 2
		direction = Vector2(-1, 0)

	if position.y < 0 or position.y > screensize.y:
		direction.y *= -1
		position.y = clamp(position.y, 0, screensize.y)


func _on_Ball_body_entered(body):
	var abs_angle = (body.position.y - self.position.y) / 16	# diff(y1, y2) / (lenght/2) = angle; -1 <= angle <= 1
	var bounce_angle = abs_angle * deg2rad(75)	# limit bouncing angle to 75°

	var side = 1 if body.position.x < screensize.x/2 else -1

	direction = Vector2(side*cos(bounce_angle), -sin(bounce_angle))	# Linear Algebra, yoh!
