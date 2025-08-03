extends CharacterBody3D

var speed := 100.0
var can_move := 1.0

var jump_height := -300.0
var jumps := 1
var max_jumps := 1

var current_grav = 200
var dir_ = 1 # 1 is normal y, 2 is inverted y, 3 is normal x, 4 is inverted x

var hp := 5
var max_hp := 5
var TB := 0
var max_TB := 10

var heal_held := 0.0
var heal_time := 0.9

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		apply_gravity(delta)
	
	if Input.is_action_just_pressed("JUMP") and jumps > 0:
		jumps -= 1
		velocity.y = jump_height
	
	if is_on_floor() and Input.is_action_pressed("HEAL"):
		heal(delta)
	else:
		heal_held = 0.0
		can_move = 1.0
	
	var dir := Input.get_axis("A", "D")
	apply_movement(dir, delta)
	
	move_and_slide()

func heal(delta):
	heal_held += delta
	if heal_held >= heal_time:
		if TB > 0 and hp < max_hp:
			hp += 1
			heal_held = 0.0
			can_move = 1.0
		else:
			heal_held = 0.0
			can_move = 0.2

func apply_gravity(delta):
	if current_grav == 0:
		current_grav = 200
	
	if dir_ == 1:
		velocity.y = current_grav
	elif dir_ == 2:
		velocity.y = current_grav * -1
	elif dir_ == 3:
		velocity.x = current_grav
	elif dir_ == 4:
		velocity.x = current_grav * -1
	else:
		dir_ = 1
		
	if not is_on_floor():
		current_grav += 150 * delta
	else:
		current_grav = 0

func apply_movement(dir, delta):
	if dir and dir_ < 3:
		velocity.x = (speed * can_move) * dir * delta
	elif dir and dir_ > 2:
		velocity.y = (speed * can_move) * dir * delta
	else:
		if dir_ < 3:
			velocity.x = 0
		elif dir_ > 2:
			velocity.y = 0
