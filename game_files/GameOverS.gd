extends CanvasLayer

onready var title = $PanelContainer/MarginContainer/Rows/Title
onready var msg = $PanelContainer/MarginContainer/Rows/msg
onready var next = $PanelContainer/MarginContainer/Rows/VBoxContainer/Next
onready var winSound = $winSound
onready var loseSound = $loseSound


func set_title(win: bool):
	if win:
		title.text = "Você ganhou!"
		msg.text = "Todos os itens foram coletados."
		title.modulate = Color.green
		next.text = "Próximo nível"
		#winSound.set_loop(false)
		winSound.play()
		
	else:
		title.text = "Você perdeu!"
		msg.text = "O vírus conseguiu te alcançar."
		title.modulate = Color.red
		next.text = "Tentar novamente"
		#loseSound.set_loop(false) 
		loseSound.play()
		
func _on_Next_pressed():
	get_tree().change_scene("res://Game.tscn")


func _on_Quit_pressed():
	get_tree().quit()
