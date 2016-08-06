extends "generic_database.gd"

const generic_database_const = preload("generic_database.gd")
const clothing_set_record_const = preload("clothing_set_record.gd")

const DATABASE_IDENT = "CLST"
const DATABASE_NAME = "clothing_set_database"
const DATABASE_NAME_JSON = "clothing_set_database.json"
const DATABASE_NAME_BINARY = "clothing_set_database.gbd"
const DATABASE_INLINED_FILENAME = "clothing_set_database_inlined.gd"
const RECORDS_NAME = "clothing_set_records"
	
func get_database_name():
	return DATABASE_NAME
	
func get_inlined_filename():
	return DATABASE_INLINED_FILENAME
	
func load_database_ids():
	return _load_database_ids(databases.path + "/" + DATABASE_NAME_JSON, RECORDS_NAME)
	
func load_database_values():
	_load_database_values(databases.path + "/" + DATABASE_NAME_JSON, RECORDS_NAME)
	
func save_database():
	_save_database(databases.path + "/" + DATABASE_NAME_JSON, RECORDS_NAME)
		
func _create_record():
	return clothing_set_record_const.new()
	
func _init(p_databases).(p_databases):
	pass