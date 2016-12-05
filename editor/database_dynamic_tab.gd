tool
extends Control

export(PackedScene) var scene = null

func create_tab():
	if(scene):
		var instance = scene.instance()
		add_child(instance)
		
func erase_tab():
	for child in get_children():
		child.queue_free()
		remove_child(child)