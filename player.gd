extends CharacterBody2D
@onready var attack_area = $AttackArea
@onready var health_bar = $"../CanvasLayer/ProgressBar"
@onready var xp_bar = $"../CanvasLayer/XPBar"
@onready var level_label = $"../CanvasLayer/Label"
@onready var anim = $Sprite2D
@onready var mana_bar = $"../CanvasLayer/ManaBar"
const SPEED = 200.0
const GRAVITY = 800.0
const JUMP_FORCE = -400.0	

var can_attack = true
var max_health = 100
var health  = 100 
var can_take_damage = true
var xp = 0
var level = 1
var xp_to_next_level = 100
var max_mana = 100
var mana = 100
var mana_regen = 0.5


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
	
	
	var style = StyleBoxFlat.new()
	style.bg_color = Color(1, 0, 0)
	style.border_width_left = 2
	style.border_width_right = 2
	style.border_width_top = 2
	style.border_width_bottom = 2
	style.border_color = Color(0.3, 0, 0)
	health_bar.add_theme_stylebox_override("fill", style)
	
	var bg_style = StyleBoxFlat.new()
	bg_style.bg_color = Color(0.1, 0.1, 0.1)
	bg_style.border_width_left = 2
	bg_style.border_width_right = 2
	bg_style.border_width_top = 2
	bg_style.border_width_bottom = 2
	bg_style.border_color = Color(0.3, 0, 0)
	health_bar.add_theme_stylebox_override("background", bg_style)
	
	var mana_style = StyleBoxFlat.new()
	mana_style.bg_color = Color(0.0, 0.3, 0.9)
	mana_style.border_width_left = 2
	mana_style.border_width_right = 2
	mana_style.border_width_top = 2
	mana_style.border_width_bottom = 2
	mana_style.border_color = Color(0.0, 0.1, 0.5)
	mana_bar.add_theme_stylebox_override("fill", mana_style)

	var mana_bg = StyleBoxFlat.new()
	mana_bg.bg_color = Color(0.1, 0.1, 0.1)
	mana_bg.border_color = Color(0.0, 0.1, 0.5)
	mana_bar.add_theme_stylebox_override("background", mana_bg)
	mana_bar.max_value = max_mana
	mana_bar.value = mana

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
	
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_FORCE
	
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	
	velocity.x = direction.x * SPEED
	move_and_slide()
	
	if mana < max_mana:
		mana += mana_regen * delta
		mana_bar.value = mana
	
	if direction.x != 0:
		anim.play("walk")
		anim.scale = Vector2(0.5, 0.5)
	else:
		anim.play("idle")
		anim.scale = Vector2(0.25, 0.25)
	if direction.x > 0:
		anim.flip_h = false
	elif direction.x < 0:
		anim.flip_h = true
		
func gain_xp(amount):		
	xp += amount 
	xp_bar.value = xp
	print("XP: ", xp, " / ", xp_to_next_level)
	if xp >= xp_to_next_level:
		level_up()
		
func level_up():
	level += 1
	xp = 0
	xp_to_next_level = int(xp_to_next_level * 1.5)
	xp_bar.value = 0
	max_health += 20
	health = max_health
	health_bar.max_value = max_health
	health_bar.value = health
	max_mana += 20
	mana = max_mana
	mana_bar.max_value = max_mana
	mana_bar.value = mana
	level_label.text = "Level: " + str(level)
	print("LEVEL ATLADI! Seviye: ", level)		
