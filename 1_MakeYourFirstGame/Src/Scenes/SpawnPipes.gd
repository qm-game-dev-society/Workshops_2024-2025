extends Node2D

@export var PipeScene : PackedScene
var currentScore : int = 0
var pipeSpeed : float = 100


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_pipe()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$UI/Score.text = str(currentScore)

func spawn_pipe() -> void:
	var tempNode : Node2D = PipeScene.instantiate()
	tempNode.position = $SpawnPoint.position
	tempNode.position.y = randi_range(300,500)
	add_child(tempNode)
	get_tree().create_timer(5).timeout.connect(spawn_pipe)



func _on_player_player_died() -> void:
	pipeSpeed = 0

func _on_player_scored() -> void:
	currentScore += 1

