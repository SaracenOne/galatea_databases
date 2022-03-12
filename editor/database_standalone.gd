@tool
extends Control

const galatea_databases_const = preload("../databases/galatea_databases.gd")

var galatea_databases = null

var galatea_database_path = "res://assets/database"
var database_popup_button = null

func _ready() -> void:
	galatea_databases = galatea_databases_const.new(galatea_database_path)
	
	galatea_databases.load_all_databases()
	
	database_interface_assign_databases(self)
	
	for tab in get_tree().get_nodes_in_group("database_editor_tab"):
		if(tab.has_method("setup")):
			tab.call("setup")
	
func database_interface_assign_databases(p_node: Node) -> void:
	for child in p_node.get_children():
		if(child.has_method("set_galatea_databases")):
			child.call("set_galatea_databases", galatea_databases)
