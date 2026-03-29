extends CharacterBody2D

const SPEED = 200.0

func _ready():
	print("SCRIPT CALISIYOR")
	var rect = ColorRect.new()
	rect.size = Vector2(50, 50)
	rect.position = Vector2(-25, -25)
	rect.color = Color.BLUE
	add_child(rect)
	
var can_attack = true

func _process(delta):
	if Input.is_action_just_pressed("attack") and can_attack:
		attack()
		
func attack():
	can_attack = false 
	print("SALDIRI!")
	await get_tree().create_timer(0.5).timeout
	can_attack = true		
		
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
