class_name Health
extends Node2D

var value: int = 0


func take_damage(damage: int) -> bool:
	value -= damage;
	if value <= 0:
		return true
		
	return false
