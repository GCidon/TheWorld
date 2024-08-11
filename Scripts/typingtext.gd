class_name NoticiaText
extends Label

@onready var type : AudioStreamPlayer = $AudioStreamPlayer

var message : String = ""

var display : String = ""

var current_char : int = 0

var isEndGame : bool = false

func start_typing(noticiero : Noticiero):
	message = noticiero.titulares[noticiero.titularesShown]
	noticiero.titularesShown += 1
	if noticiero.titulares.size() == 1:
		isEndGame = true
	if noticiero.titularesShown == noticiero.titulares.size():
		noticiero.finished = true
		Globals.noticiero_finished.emit()
	display = ""
	current_char = 0
	
	set("theme_override_colors/font_color", noticiero.color)
	
	$next_char.set_wait_time(randf_range(0.03, 0.1))
	$next_char.start()

func _on_next_char_timeout():
	if current_char < len(message):
		var next_char = message[current_char]
		display += next_char
		text = display
		current_char+=1
		$next_char.set_wait_time(randf_range(0.03, 0.1))
		$next_char.start()
		type.play()
	else:
		$next_char.stop()
		Globals.noticia_ended.emit(isEndGame)
