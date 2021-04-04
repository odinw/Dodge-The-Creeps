extends Area2D

export var speed = 400
var sreen_size
signal hit

func _ready():
	sreen_size = get_viewport_rect().size
	hide()

func _process(delta):
	var velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
		
	position += velocity * delta
	position.x = clamp(position.x, 0, sreen_size.x)
	position.y = clamp(position.y, 0, sreen_size.y)

	if velocity.x != 0:
		$AnimatedSprite.play("walk")
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite.play("up")
		$AnimatedSprite.flip_v = velocity.y > 0

func _on_Player_body_entered(body):
	hide()
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disable", true)
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.set_deferred("disable", false)
