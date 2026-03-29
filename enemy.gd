extends CharacterBody2D

var health = 100
var speed = 80
var player = null

func _ready():
	var rect = ColorRect.new()
	rect.size = Vector2(50, 50)
	rect.position = Vector2(-25, -25)
	rect.color = Color.RED
	add_child(rect)
	player = get_tree().get_first_node_in_group("player")

func _physics_process(delta):
	if player:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * speed
		move_and_slide()

func take_damage(amount):
	health -= amount
	print("Düşman canı: ", health)
	if health <= 0:
		die()

func die():
	print("Düşman öldü!")
	queue_free()	
