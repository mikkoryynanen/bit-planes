extends KinematicBody2D

var speed = 250

var direction = Vector2.UP

const HitParticle = preload("res://Effects/HitParticle.tscn")


func _physics_process(delta):
	move_and_collide(direction * delta * speed)


func _on_Hitbox_area_entered(area:Area2D):
	var hit = HitParticle.instance()
	get_tree().get_root().get_node("World").call_deferred("add_child", hit)
	hit.global_position = self.global_position
	hit.emitting = true
			
	queue_free()
