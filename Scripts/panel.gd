extends Panel

@export var mediaDays : int = 10
@export var deltaDays : int = 3

@export var noticiasRandom : Noticiero = null
@export var noticiasGuerra : Noticiero = null
@export var noticiasRosa : Noticiero = null
@export var noticiasPersonal : Noticiero = null
@export var noticiasIndie : Noticiero = null
@export var noticiasEnd : Noticiero = null

@export var noticiaLabel : NoticiaText = null

var actualMediaDays : int = 0
var countDays : int = 0

var waitingForNoticiaEnded = false

var allNoticierosEnded : int = 0
var endGame : bool = false
var trueEndGame : bool = false

func _ready():
	Globals.day_passed.connect(on_day_passed)
	Globals.noticia_ended.connect(on_noticia_ended)
	Globals.noticiero_finished.connect(on_noticiero_finished)
	actualMediaDays = randi_range(mediaDays - deltaDays, mediaDays + deltaDays)
	
func on_day_passed():
	countDays += 1
	if not trueEndGame:
		if countDays >= actualMediaDays:
			countDays = 0
			actualMediaDays = randi_range(mediaDays - deltaDays, mediaDays + deltaDays)
			
			if not waitingForNoticiaEnded:
				noticiaLabel.start_typing(get_random_noticiero())
				waitingForNoticiaEnded = true
				var fade = create_tween()
				fade.tween_property(self, "modulate:a", 1.0, 1.0)
				fade.play()
	
func get_random_noticiero():
	var noticiero : Noticiero = null
	var noticieroNotFull = false
	if not endGame:
		while not noticieroNotFull:
			var randNot = randi_range(0, 4)
			match randNot:
				0:
					noticiero = noticiasGuerra
				1:
					noticiero = noticiasRosa
				2:
					noticiero = noticiasPersonal
				3:
					noticiero = noticiasRandom
				4:
					noticiero = noticiasIndie
			noticieroNotFull = not noticiero.finished
	else:
		noticiero = noticiasEnd
			
	return noticiero
	
func on_noticia_ended(isendgame):
	var fade = create_tween()
	fade.tween_property(self, "modulate:a", 0.0, 3.0)
	fade.tween_callback(func():
		waitingForNoticiaEnded = false
		)
	fade.play()
	trueEndGame = isendgame
	
func on_noticiero_finished():
	allNoticierosEnded += 1
	if allNoticierosEnded == 5:
		endGame = true
