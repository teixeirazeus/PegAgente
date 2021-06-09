extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

var count = 0

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			if count == 0:
				texture = load("res://tilesets/screen3.png")
			elif count == 1:
				texture = load("res://tilesets/screen4.png")
			count += 1
			
