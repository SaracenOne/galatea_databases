@tool
extends Control

@export var scene: PackedScene = null
var galatea_databases = null

func create_tab():
	if(scene):
		var instance = scene.instantiate()
		if(instance.has_method("set_galatea_databases")):
			instance.call_deferred("set_galatea_databases", galatea_databases)
			
		add_child(instance)
		
func erase_tab():
	if(scene):
		for child in get_children():
			child.queue_free()
			remove_child(child)
			
func set_galatea_databases(p_databases):
	galatea_databases = p_databases
	for child in get_children():
		if(child.has_method("set_galatea_databases")):
			child.call("set_galatea_databases", p_databases)
