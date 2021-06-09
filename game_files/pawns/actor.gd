extends "pawn.gd"

onready var Grid = get_parent()


func _ready():
	update_look_direction(Vector2(1, 0))

func _process(delta):
	var input_direction = get_input_direction()
	if not input_direction:
		return
	update_look_direction(input_direction)

	var target_position = Grid.request_move(self, input_direction)
	if target_position:
		move_to(target_position)
	else:
		bump()

func get_input_direction():
	return Vector2(
		int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")),
		int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	)

func update_look_direction(direction):
	#$Sprite.rotation = direction.angle()
	pass

func to_map(position):
	return [(position[0]-96)/64, (position[1]-160)/64]

func move_to(target_position):
	#print("Real:",position)
	#print("Mapeada:", to_map(position))
	set_process(false)
	
	#$AnimationPlayer.play("walk")

	# Move the node to the target cell instantly,
	# and animate the sprite moving from the start to the target cell
	var move_direction = (target_position - position).normalized()
	if move_direction[1] == 0:
		if move_direction[0] == -1:
			#print("Esquerda")
			$AnimationPlayer.play("Esquerda")
		elif move_direction[0] == 1:
			#print("Direita")
			$AnimationPlayer.play("Direita")
	elif move_direction[1] == -1:
		#print("Cima")
		$AnimationPlayer.play("Cima")
	elif move_direction[1] == 1:
		#print("Baixo")
		$AnimationPlayer.play("Baixo")
	else:
		$AnimationPlayer.play("walk")
	#print('>',move_direction, move_direction[0] == -1 and move_direction[1] == 0)
	
	$Tween.interpolate_property(
		self,"position",
		position,target_position,
		$AnimationPlayer.current_animation_length,
		Tween.TRANS_LINEAR, Tween.EASE_IN)

	$Tween.start()

	# Stop the function execution until the animation finished
	yield($AnimationPlayer, "animation_finished")
	
	set_process(true)


func bump():
	set_process(false)
	$AnimationPlayer.play("bump")
	yield($AnimationPlayer, "animation_finished")
	set_process(true)
