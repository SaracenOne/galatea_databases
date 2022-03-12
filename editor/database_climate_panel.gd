@tool
extends "./database_panel.gd"

const climate_record_const = preload("../databases/climate_record.gd")

func _ready():
	pass

func galatea_databases_assigned():
	super.galatea_databases_assigned()
	
	current_database = galatea_databases.climate_database
	if(current_database != null):
		database_records.populate_tree(current_database, null)
	else:
		printerr("climate_database is null")

func set_current_record_callback(p_record):
	super.set_current_record_callback(p_record)
