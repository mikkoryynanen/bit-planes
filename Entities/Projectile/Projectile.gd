class_name Projectile
extends KinematicBody2D

var speed = 250
var direction = Vector2.UP
var lifetime = 3

var timer: float = 0.0
const HitParticle = preload("res://Effects/HitParticle.tscn")



func _physics_process(delta):
	move_and_collide(direction * delta * speed)

	if timer >= lifetime:
		destroy()
	else:
		timer += delta


func _on_Hitbox_area_entered(area: Area2D):
	var hit = HitParticle.instance()
	get_tree().root.call_deferred("add_child", hit)
	hit.global_position = self.global_position
	hit.emitting = true
			
	destroy()


func destroy():
	queue_free()
