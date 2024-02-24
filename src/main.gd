extends Node

func _ready():
	add_child(load("res://scenes/Menu.tscn").instantiate())
