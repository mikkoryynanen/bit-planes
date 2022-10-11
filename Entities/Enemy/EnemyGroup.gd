extends Node2D

const Enemy = preload("res://Entities/Enemy/Enemy.tscn")


func _ready():
	for i in 3:
		var enemy = Enemy.instance()
		add_child(enemy)
		enemy.global_position = Vector2(-50, 20 * i)
		enemy.set_direction(Vector2.RIGHT)
