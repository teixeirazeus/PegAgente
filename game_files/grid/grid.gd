extends TileMap
var level = 1
var itens = 6
enum { EMPTY = -1, ACTOR, OBSTACLE, OBJECT}
const GameOverS = preload("res://GameOverS.tscn")
onready var label_level = get_parent().get_node("level_label")

func _ready():
	for child in get_children():
		set_cellv(world_to_map(child.position), child.type)
	var file = File.new()
	file.open("res://level", File.READ)
	level = int(file.get_line())
	file.close()
	print('Level:',level)
	
	label_level.text = "Nível:"+str(level)
	get_tree().paused = false
		
func get_cell_pawn(coordinates):
	for node in get_children():
		if world_to_map(node.position) == coordinates:
			return(node)

func request_move(pawn, direction):
	var cell_start = world_to_map(pawn.position)
	var cell_target = cell_start + direction
	
	var cell_target_type = get_cellv(cell_target)
	#if pawn.name == "Actor":
	match cell_target_type:
		EMPTY:
			return update_pawn_position(pawn, cell_start, cell_target)
		OBJECT:
			# if pawn.name == "Actor":
			var object_pawn = get_cell_pawn(cell_target)
			object_pawn.queue_free()
			itens = itens - 1
			if itens == 0:
				#level up
				if level != 9:
					level = level + 1
					var file = File.new()
					file.open("res://level", File.WRITE)
					file.store_line(str(level))
					file.close()
				var game_over = GameOverS.instance()
				add_child(game_over)
				game_over.set_title(true)
				get_tree().paused = true
				# get_tree().reload_current_scene()
			return update_pawn_position(pawn, cell_start, cell_target)
		ACTOR:
			var game_over = GameOverS.instance()
			add_child(game_over)
			game_over.set_title(false)
			get_tree().paused = true
			#var pawn_name = get_cell_pawn(cell_target).name
			#print("Cell %s contains %s" % [cell_target, pawn_name])
			
			# get_tree().reload_current_scene()
			#get_tree().call_group("respawn","_ready")

func update_pawn_position(pawn, cell_start, cell_target):
	set_cellv(cell_target, pawn.type)
	set_cellv(cell_start, EMPTY)
	return map_to_world(cell_target) + cell_size / 2
