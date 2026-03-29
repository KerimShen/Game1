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
	
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_down"):
		direction.y += 1
	if Input.is_action_pressed("move_up"):
		direction.y -= 1
	
	velocity = direction.normalized() * SPEED
	move_and_slide()
	
	velocity = direction.normalized() * SPEED
	move_and_slide()

func _process(delta):
	print(velocity)
