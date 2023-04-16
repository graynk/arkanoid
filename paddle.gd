extends CharacterBody2D
@export var SPEED: int = 600


func _physics_process(delta):
	var direction = Input.get_axis("left", "right")
	if not direction:
		return
	velocity.x = direction * SPEED
	velocity.y = 0
	move_and_slide()
