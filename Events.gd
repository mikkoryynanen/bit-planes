extends Node2D


# CORE
signal on_scored(value)
signal update_score_ui(value)
signal on_enemy_destroyed(entity)
signal on_enemy_path_destroy(path_node)
signal on_take_damage(current_value)
signal on_group_cleared()

signal on_level_completed()
signal on_boss_reached()
signal on_boss_take_damage(value)

signal on_collected()


# BuildMenu
signal on_item_attached(item_data, slot_id)
signal on_item_inventory(item_data)

# SFX
signal add_stream_player(entity)
signal play_entity_sound(entity)