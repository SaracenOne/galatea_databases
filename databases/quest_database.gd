extends "generic_database.gd"

const generic_database_const = preload("generic_database.gd")
const quest_record_const = preload("quest_record.gd")

const DATABASE_IDENT = "QUST"
const DATABASE_NAME = "quest_database"
const DATABASE_NAME_JSON = "quest_database.json"
const DATABASE_NAME_BINARY = "quest_database.gbd"
const DATABASE_INLINED_FILENAME = "quest_database_inlined.gd"
const RECORDS_NAME = "quest_records"
	
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
	return quest_record_const.new()
	
func _init(p_databases).(p_databases):
	pass