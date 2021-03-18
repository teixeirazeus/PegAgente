#extends Node2D
extends "pawn.gd"

onready var Grid = get_parent()


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var playerNode
var brain = []
var level = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	#print("Petisco")
	playerNode = get_tree().get_root().get_node("Game/Grid/Actor")
	
	var file = File.new()
	file.open("res://level", File.READ)
	level = int(file.get_line())
	file.close()

	#var file = File.new()
	file.open("res://brains/"+str(level)+".brain", File.READ)
	#var content = file.get_as_text()
	#while not file.eof_reached():
	brain = []
	for i in range(20):
		brain.append([])
		brain[i] = []
		for j in range(20):
			brain[i].append([])
			brain[i][j] = []
			for x in range(20):
				brain[i][j].append([])
				brain[i][j][x] = []
				for y in range(20):
					brain[i][j][x].append([])
					var line = file.get_line()
					brain[i][j][x][y] = int(line)
					#print(line)
	file.close()
	################
	
	pass # Replace with function body.
	
func to_map(position):
	return [int((position[0]-96)/64), int((position[1]-160)/64)]
	
func _process(delta):
	var dir = [Vector2(0,-1), Vector2(0,1), Vector2(1,0), Vector2(-1,0)]
	#var input_direction = dir[randi() % dir.size()]
	var x = to_map(playerNode.position)
	var y = to_map(position)
	var input_direction = dir[brain[x[0]][x[1]+1][y[0]][y[1]+1]]
	#print("TEST:",input_direction)
	#print("Virus para:", input_direction)
	#print("Inimigo em:",to_map(position))
	#print("Vê jogador em:", to_map(playerNode.position))
	#var input_direction = get_input_direction()

	var target_position = Grid.request_move(self, input_direction)
	if target_position:
		move_to(target_position)
	#else:
	#	bump()


func move_to(target_position):
	#print("Real:",position)
	#print("Mapeada:", to_map(position))
	set_process(false)
	
	var move_direction = (target_position - position).normalized()
	
	$AnimationPlayer.play("Walk")
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

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
