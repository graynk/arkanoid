extends Node2D
@export var ball_speed: int = 500
var ball: PackedScene = preload("res://ball.tscn")
var lives: int = 3
var brick_count: int = 0

func _ready():
	RenderingServer.set_default_clear_color('494aa6')
	spawn_ball()
	brick_count = len(get_tree().get_nodes_in_group('bricks'))
	
func spawn_ball():
	var spawned: Node2D = ball.instantiate()
	spawned.position = get_viewport_rect().size
	spawned.position.x = spawned.position.x / 2 - 40
	spawned.position.y *= 3/4.0
	spawned.velocity = Vector2(ball_speed, ball_speed)
	add_child(spawned)
	spawned.connect('despawn', _on_ball_despawn)
	spawned.connect('brick_hit', _on_brick_hit)


func _on_ball_despawn():
	lives -= 1
	if lives > 0:
		spawn_ball()
		return
	if brick_count == 0:
		return
	$GUI/State.text = 'Loh'
	$GUI/State.visible = true
	$Sounds/FailSound.play()

func _on_brick_hit():
	brick_count -= 1
	if brick_count > 0:
		return
	$GUI/State.text = 'Ne Loh'
	$GUI/State.visible = true
	$Sounds/WinSound.play()
	
