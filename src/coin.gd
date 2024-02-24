extends Area2D

signal coin_collected

func _ready():
	$AnimatedSprite2D.play()

func _on_area_entered(_area):
	coin_collected.emit()
	queue_free()
