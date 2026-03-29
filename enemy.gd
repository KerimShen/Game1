extends CharacterBody2D

var health = 100

func _ready():
	var rect = ColorRect.new()
	rect.size = Vector2(50, 50)
	rect.position = Vector2(-25, -25)
	rect.color = Color.RED
	add_child(rect)

func take_damage(amount):
	health -= amount
	print("Düşman canı: ", health)
	if health <= 0:
		die()

func die():
	print("Düşman öldü!")
	queue_free()
