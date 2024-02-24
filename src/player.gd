extends CharacterBody2D

@onready var animation = $AnimationPlayer
@onready var sprite = $Sprite2D
const ACCELERATION = 750 # Ускорение игрока
const MAX_SPEED = 150 # Макисмальная скорость
const FRICTION = 0.25 # Сила трения
const GRAVITY = 1000 # Гравитация
const JUMP_FORCE = 400 # Сила прыжка
const AIR_RESISTANCE = 0.1 # Сопротивление воздуха

var hp = 3 # Число очков жизни у игрока
var coins = 0 # Количество монет, собранных игроком на уровне

func _physics_process(delta):
	var x_input = Input.get_action_strength("right") - Input.get_action_strength("left")
	
	if x_input != 0:
		animation.play("Move")
		velocity.x += x_input * ACCELERATION * delta
		velocity.x = clamp(velocity.x, -MAX_SPEED, MAX_SPEED)
		sprite.flip_h = x_input < 0
	else:
		animation.play("Idle")
	
	velocity.y += GRAVITY * delta
	
	if is_on_floor():
		if x_input == 0:
			velocity.x = lerp(velocity.x, 0.0, FRICTION)
		
		if Input.is_action_just_pressed("up"):
			velocity.y = -JUMP_FORCE
	else:
		animation.play("Jump")
		
		if Input.is_action_just_released("up") and velocity.y < -JUMP_FORCE / 2:
			velocity.y = -JUMP_FORCE / 2
			
		if x_input == 0:
			velocity.x = lerp(velocity.x, 0.0, AIR_RESISTANCE)
	
	move_and_slide()
	
	if position.y >= 1200: # Если игрок падает вниз, то перезапускаем уровень
		get_tree().reload_current_scene.call_deferred()


func on_coin_collected():
	coins += 1
	$HUD/Coins/Count.text = str(coins)
