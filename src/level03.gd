extends Node2D

@onready var player = $Player

func _ready():
	for i in range(1, $Coins.get_child_count() + 1):
		get_node("Coins/Coin{0}".format([i])).connect("coin_collected", _on_coin_collected)
	
	$LevelTrigger.connect("level_trigger_activated", _on_level_trigger_activated)

func _on_coin_collected():
	player.on_coin_collected()

func _on_level_trigger_activated():
	get_tree().change_scene_to_file.call_deferred("res://scenes/EndScreen.tscn")
