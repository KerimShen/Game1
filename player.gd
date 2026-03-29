extends CharacterBody2D

const SPEED = 200.0

func _ready():
	print("SCRIPT CALISIYOR")
	var rect = ColorRect.new()
	rect.size = Vector2(50, 50)
	rect.position = Vector2(-25, -25)
	rect.color = Color.BLUE
	add_child(rect)

func _physics_process(delta):
	var direction = Vector2.ZERO
	
	if Input.is_key_pressed(KEY_RIGHT):
		direction.x += 1
	if Input.is_key_pressed(KEY_LEFT):
		direction.x -= 1
	if Input.is_key_pressed(KEY_DOWN):
		direction.y += 1
	if Input.is_key_pressed(KEY_UP):
		direction.y -= 1
	
	velocity = direction.normalized() * SPEED
	move_and_slide()

func _process(delta):
	print(velocity)
