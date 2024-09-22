extends Node2D

var gameover : bool = false



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not gameover:
		position.x -= get_parent().pipeSpeed * delta


func when_gameover() -> void:
	gameover = true