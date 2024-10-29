extends Area2D

func _physics_process(delta: float) -> void:
	position += transform.y * 10




func _on_area_entered(area: Area2D) -> void:
	print("hit")
	if area is Enemy:
		(area as Enemy).whenHit(5)
