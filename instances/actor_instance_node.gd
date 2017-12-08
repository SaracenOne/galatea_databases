extends "record_instance_node.gd"
tool

func get_valid_database():
	if databases:
		return databases.actor_database
	return null
