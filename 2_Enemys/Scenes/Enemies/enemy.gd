class_name Enemy
extends Area2D

@export var SPEED : float


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = position.move_toward(Global.player.position, delta * SPEED)

func whenKilled() -> void:
	print("enemy died")
	queue_free()

func whenHit(attack : int) -> void:
	($Health as Health).takeHit(attack)

func _on_health_died() -> void:
	whenKilled()
