extends CharacterBody2D
signal despawn
signal brick_hit
signal other_hit
@export var ball_size: int = 10

func _draw():
	draw_circle(Vector2.ZERO, ball_size, Color.DARK_SEA_GREEN)


func _on_visible_on_screen_notifier_2d_screen_exited():
	despawn.emit()
	queue_free()

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if not collision:
		return
	velocity = velocity.bounce(collision.get_normal())
	var bricks = get_tree().get_nodes_in_group('bricks')
	var collider = collision.get_collider()
	if collider not in bricks:
		other_hit.emit()
		return
	collider.queue_free()
	brick_hit.emit()


func _on_brick_hit():
	$HitSound.pitch_scale = 1
	$HitSound.play()


func _on_other_hit():
	$HitSound.pitch_scale = 1.5
	$HitSound.play()
