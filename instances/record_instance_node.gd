tool
extends Spatial

var databases = null
export(String) var id = "" setget set_id

func set_id(p_id):
	id = p_id
	property_list_changed_notify()

func get_valid_database():
	return null

func set_databases(p_databases):
	databases = p_databases
	
func _ready():
	if Engine.is_editor_hint():
		set_scene_instance_load_placeholder(true)
	else:
		if is_inside_tree():
			queue_free()