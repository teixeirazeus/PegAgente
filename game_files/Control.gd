extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():

	var file = File.new()
	file.open("res://level", File.WRITE)
	file.store_line("1")
	file.close()




# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

var count = 0

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			if count == 2:
				$FadeIn.show()
				$FadeIn.fade_in()
			count += 1
			


func _on_FadeIn_fade_finished():
	get_tree().change_scene("res://Game.tscn")
