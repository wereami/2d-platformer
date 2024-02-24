extends Area2D

signal level_trigger_activated

func _ready():
	$AnimatedSprite2D.play()

func _on_area_entered(_area):
	level_trigger_activated.emit()
