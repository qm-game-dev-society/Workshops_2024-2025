class_name Player
extends CharacterBody2D


const SPEED = 300.0
@export var bulletScene : PackedScene 

func _ready() -> void:
	Global.player = self


func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var horizontal := Input.get_axis("PLAYER_left", "PLAYER_right")
	var vertical := Input.get_axis("PLAYER_up", "PLAYER_down")
	if horizontal:
		velocity.x = horizontal * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if vertical:
		velocity.y = vertical * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
		
	velocity = velocity.normalized() * (velocity.length() if velocity.length() < SPEED else SPEED)
	
	move_and_slide()
	
	if Input.is_action_just_pressed("PLAYER_attack"):
		attack()

func attack() -> void:
	var tempScene : Node2D = bulletScene.instantiate()
	tempScene.position = position
	tempScene.rotation = (get_global_mouse_position() - position).angle() - PI * 0.5 
	print(tempScene.rotation)
	get_parent().add_child(tempScene)
	
	
	
