extends Label

var days : int = 0

func _ready():
	Globals.day_passed.connect(_on_day_passed)

func _on_day_passed():
	days += 1
	if days >= 365:
		text = "Año " + str(days/365) + ", día " + str(days - (days/365)*365 + 1)
	else:
		text = "Día " + str(days+1)
