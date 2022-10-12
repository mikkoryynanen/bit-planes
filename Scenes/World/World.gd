extends Node2D

var score = 0
var collectables = 0
var spawnedEnemiesCount: int = 0

enum {
   RUNNING,
   COMPLETED
}
var state = RUNNING

func _ready():
   Events.connect("on_scored", self, "set_score")
   Events.connect("on_enemy_destroyed", self, "check_for_enemies")
   Events.connect("on_collected", self, "on_collected")

   spawn_enemy_groups()	   

func spawn_enemy_groups():
   # TODO logic to spawn enemy waves when certain time has passed
   # since we are not moving the camera this is the only viable option
   
   var EnemyGroupScene = load("res://Entities/Enemy/EnemyGroup.tscn")
   var enemyGroup = EnemyGroupScene.instance()
   self.add_child(enemyGroup)
   
   spawnedEnemiesCount += enemyGroup.count

func check_for_enemies():
   spawnedEnemiesCount -= 1
   
   # Check for game over state
   if spawnedEnemiesCount <= 0:
	   get_tree().change_scene("res://Scenes/MainMenu/MainMenu.tscn")
	   Events.emit_signal("on_level_completed")
	  
   # TODO Take into account missed enemies

func on_collected():
   collectables += 10
   set_score(1)

   FileManager.save_collectables(collectables)

func set_score(value):
   score += value

   Events.emit_signal("update_score_ui", score)
