extends Node
	
const galatea_databases_const = preload("databases/galatea_databases.gd")

var databases_instance = null

func load_all_databases():
	return databases_instance.load_all_databases()
	
func _ready():
	databases_instance = galatea_databases_const.new("res://assets/database")
	
	load_all_databases()
