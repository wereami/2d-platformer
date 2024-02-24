extends Area2D

@onready var player = $"../." # Родительский узел Player
@onready var hp_bar = $"../HUD/HP"

func _on_Hitbox_area_entered(area):
	if area.is_in_group("Spikes"): # Если коллизия является шипом
		hp_bar.remove_child(get_node("../HUD/HP/Heart{0}".format([player.hp]))) # Убираем сердце из полоски
		player.hp -= 1
		
		if player.hp <= 0:
			player.hp = 3
			get_tree().reload_current_scene.call_deferred()
