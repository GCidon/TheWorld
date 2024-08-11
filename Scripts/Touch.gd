extends RigidBody3D

var isDraggin : bool = false
var isGirando : bool = false
var isGirandoAuto : bool = false

var clickPos : Vector2 = Vector2.ZERO

var initialRotation : float = 0.0
var actualRotation : float = 0.0
var anglesRotated : float = 0.0

var spins : int = 1

func _process(delta):
	if isGirando:
		rotation_degrees.y -= 5
		anglesRotated -= 5
		
	if isGirandoAuto:
		rotation_degrees.y -= 0.5
		anglesRotated -= 0.5
	
	if isDraggin:
		var distance = get_viewport().get_mouse_position().x - clickPos.x
		var percentageToScreen = (distance / get_viewport().size.x)
		if percentageToScreen > 0:
			percentageToScreen = 0.0
			
		rotation_degrees.y = initialRotation + percentageToScreen*360
	
	if abs(anglesRotated)>360*spins:
		spins+=1
		Globals.day_passed.emit()
	
func _input(event):
	
	if event.is_action_pressed("girar"):
		isGirando = true
		isGirandoAuto = false
	if event.is_action_released("girar"):
		isGirando = false
		isGirandoAuto = false
		
	if event.is_action_pressed("auto"):
		isGirandoAuto = not isGirandoAuto
		isGirando = false
		
	if not isDraggin:
		isDraggin = event.is_action_pressed("click")
		if isDraggin:
			clickPos = get_viewport().get_mouse_position()
			initialRotation = rotation_degrees.y
			actualRotation = rotation_degrees.y
	else:
		isDraggin = not event.is_action_released("click")
		if not isDraggin:
			anglesRotated+=rotation_degrees.y-initialRotation
	
