extends KinematicBody2D

export var speed = 250

const HitParticle = preload("res://Effects/HitParticle.tscn")


func _physics_process(delta):
	move_and_collide(Vector2.UP * delta * speed)

func _on_Hitbox_area_entered(area:Area2D):
	var hit = HitParticle.instance()
	get_tree().get_root().call_deferred("add_child", hit)
	hit.global_position = self.global_position
	hit.emitting = true
			
	queue_free()
