extends TextureRect

var atlas : AtlasTexture = null

var frames = 2

var actualFrame = 0

func _ready():
	atlas = texture as AtlasTexture
	$next_frame.start()

func _on_next_frame_timeout():
	atlas.region.position.x = actualFrame * 128
	actualFrame+=1
	if actualFrame == frames:
		actualFrame = 0
