tool
extends Control

const galatea_databases_const = preload("../databases/galatea_databases.gd")

var galatea_databases = null

var galatea_database_path = "res://assets/database"
var database_popup_button = null

var database_popup_instance = null

func _ready():
	galatea_databases = galatea_databases_const.new(galatea_database_path)
	
	galatea_databases.load_all_databases()
	
	database_interface_assign_databases(self)
	
func database_interface_assign_databases(p_control):
	for child in p_control.get_children():
		if(child.has_method("set_galatea_databases")):
			child.call("set_galatea_databases", galatea_databases)
		database_interface_assign_databases(child)