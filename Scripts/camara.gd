extends Camera3D

@export var world : Node3D = null

@onready var timer = $Timer

var distance : float = 2.0

var nextPosition : Vector3 = Vector3.ZERO

var moving : bool = false

func _ready():
	distance = (world.position - self.position).length()
	nextPosition = position

func _process(delta):
	look_at(world.position)
	
	if not moving:
		nextPosition = find_new_position()
		moving = true
		timer.start()
		
	position = lerp(position, nextPosition, 0.1*delta)

func find_new_position():
	var newpos = Vector3.ZERO
	while (newpos - position).length() > 1.0:
		var dir : Vector3 = Vector3(0,0,0)
		while dir.length() == 0:
			dir = Vector3(randf_range(-1.0, 1.0), randf_range(-0.5, 0.5), randf_range(-1.0,1.0))
		dir = dir.normalized()
		
		newpos = world.position + dir*distance
	return newpos


func _on_timer_timeout():
	moving = false
