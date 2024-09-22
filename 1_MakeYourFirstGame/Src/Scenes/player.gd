extends Area2D

var gameover : bool = false

const JUMP_VELOCITY = -400
var velocity : float

signal playerDied
signal scored

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !gameover:
		if Input.is_action_just_pressed("Jump") and not on_ceiling():
			$JumpSound.play()
			velocity = JUMP_VELOCITY

	velocity += get_gravity() * delta

	position.y += velocity * delta

	position.y = clamp(position.y, 0, 800)

	if position.y > 720:
		died()


func on_ceiling() -> bool:
	return position.y < 3

func _on_area_entered(area:Area2D) -> void:
	if area.is_in_group("Pipe"):
		died()
	if area.is_in_group("ScoreArea"):
		score()

func score() -> void:
	scored.emit()
	$ScoreSound.play()

func died() -> void:
	if not gameover:
		gameover = true
		$DeadSound.play()
		playerDied.emit()