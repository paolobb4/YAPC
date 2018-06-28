extends Area2D


var velocity = Vector2(132, 132)
var screensize


func _ready():
	screensize = get_viewport().size


func _process(delta):
	position += velocity * delta
	# TODO: replace x collision with point score
	if position.x < 0 or position.x > screensize.x:
		velocity.x *= -1
		position.x = clamp(position.x, 0, screensize.x)
	if position.y < 0 or position.y > screensize.y:
		velocity.y *= -1
		position.y = clamp(position.y, 0, screensize.y)


func _on_Ball_body_entered(body):
	velocity.x *= -1
