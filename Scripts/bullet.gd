extends CharacterBody2D

const hostile_script = preload('res://Scenes/world.tscn')

var bullet_velocity = Vector2(1, 0)
var bullet_speed = 300

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(bullet_velocity.normalized() * delta * bullet_speed)
	if collision:
		if collision.get_collider().name == "hostile1":
			pass
			#$hostile1.dead = true
		print(collision.get_collider().name)
		queue_free()
