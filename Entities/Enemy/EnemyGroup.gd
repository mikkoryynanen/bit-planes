extends Node2D

class_name EnemyGroup

export(int) var count = 3


func _ready():
	for i in count:
		var Enemy = load("res://Entities/Enemy/Enemy.tscn")
		var enemy = Enemy.instance()
		add_child(enemy)
		enemy.global_position = Vector2(-50, 20 * i)
		enemy.init(Vector2.RIGHT, self)
