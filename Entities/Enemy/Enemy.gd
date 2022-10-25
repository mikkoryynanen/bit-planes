extends KinematicBody2D

class_name Enemy

export var health = 75
export var collectablesCount = 3

var direction: Vector2
var group: EnemyGroup = null

onready var animation_player = $AnimationPlayer

const Collectable = preload("res://Entities/Collectable/Collectable.tscn")


# This is set from the enemy group manager
func init(_group: EnemyGroup):
	group = _group


func _ready():
	Events.emit_signal("add_stream_player", self)


func _on_Hitbox_area_entered(area: Area2D):
	health -= PlayerStats.damage
	
	if health <= 0:
		Events.emit_signal("on_scored", 10)
		Events.emit_signal("on_enemy_destroyed", get_parent().get_parent())
		Events.emit_signal("play_entity_sound", self, Sound.Explosion)
		
		# Release collectables upon dying
		for i in collectablesCount:
			var collectable = Collectable.instance()
			get_tree().get_root().call_deferred("add_child", collectable)
			
			collectable.global_position = self.global_position + Vector2.ONE * randf() * 15
			
			# TODO REMOVE
			collectable.scale = Vector2.ONE * 0.5

		queue_free()

	else:
		Events.emit_signal("play_entity_sound", self, Sound.Hit)
		animation_player.play("Flash")

