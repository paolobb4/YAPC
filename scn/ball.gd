extends Area2D


var direction = Vector2(-1,1).normalized()
var speed = 100
var screensize


func _ready():
	screensize = get_viewport_rect().size


func _process(delta):
	position += direction * speed * delta
	# TODO: replace x collision with point score
	if position.x < 0 or position.x > screensize.x:
		direction.x *= -1
		position.x = clamp(position.x, 0, screensize.x)
	if position.y < 0 or position.y > screensize.y:
		direction.y *= -1
		position.y = clamp(position.y, 0, screensize.y)


func _on_Ball_body_entered(body):
	direction.x *= -1
