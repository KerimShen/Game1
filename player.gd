extends CharacterBody2D
@onready var attack_area = $AttackArea
@onready var health_bar = $"../CanvasLayer/ProgressBar"
const SPEED = 200.0

var can_attack = true
var health  = 100 
var can_take_damage = true

func take_damage(amount):
	if can_take_damage:
		health -= amount
		health_bar.value = health
		print("Oyuncu cani: ", health)
		can_take_damage = false
		await get_tree().create_timer(1.0).timeout
		can_take_damage = true 
		if health <= 0:
			die() 

func die():
	print("You Die!")
	get_tree().reload_current_scene()

func _ready():
	attack_area.monitoring = false

func _process(delta):
	if Input.is_action_just_pressed("attack") and can_attack:
		attack()

func attack():
	can_attack = false
	attack_area.monitoring = true 
	print("SALDIRI!")
	
	await get_tree().create_timer(0.1).timeout
	
	var bodies = attack_area.get_overlapping_bodies()
	print("Bulunan düşman sayısı: ", bodies.size())
	for body in bodies:
		if body.has_method("take_damage"):
			body.take_damage(25)
	
	await get_tree().create_timer(0.3).timeout
	attack_area.monitoring = false 
	await get_tree().create_timer(0.2).timeout
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
