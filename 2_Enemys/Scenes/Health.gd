class_name Health
extends Node

@export var MaxHealth : int = 10
var currentHealth : int 
var dead : bool = false

signal died()

func setupHealth():
	currentHealth = MaxHealth

func takeHit(attack : int) -> void:
	currentHealth -= attack
	checkIfDead()

func checkIfDead() -> void:
	if currentHealth <= 0:
		dead = true
		died.emit()
