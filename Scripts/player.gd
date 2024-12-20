extends CharacterBody2D

const bulletPath = preload('res://Scenes/bullet.tscn')

const SPEED = 250.0
const JUMP_VELOCITY = -300.0

var double_jump = 1
var last_direction = 1

func shoot(bullet_direction):
	var bullet = bulletPath.instantiate()
	
	get_parent().add_child(bullet)
	bullet.bullet_velocity.x = bullet_direction
	bullet.position = $Marker2D.global_position
	bullet.position += transform.x * bullet_direction * 20

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if is_on_floor():
		double_jump = 1

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and double_jump > 0:
		velocity.y = JUMP_VELOCITY
		if not Globals.double_jump_unlocked:
			double_jump = 0
		elif not is_on_floor():
			double_jump = double_jump - 1

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		last_direction = direction
		velocity.x = direction * SPEED
		$AnimatedSprite2D.flip_h = (direction == -1)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if Input.is_action_just_pressed("ui_down"):
		shoot(last_direction)
		

	move_and_slide()
