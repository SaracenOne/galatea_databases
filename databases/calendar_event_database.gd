extends "generic_database.gd"

const generic_database_const = preload("generic_database.gd")
const calendar_event_record_const = preload("calendar_event_record.gd")

const DATABASE_IDENT = "CALE"
const DATABASE_NAME = "calendar_event_database"
const DATABASE_NAME_JSON = "calendar_event_database.json"
const DATABASE_NAME_BINARY = "calendar_event_database.gbd"
const DATABASE_INLINED_FILENAME = "calendar_event_database_inlined.gd"
const RECORDS_NAME = "calendar_event_records"
	
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
	return calendar_event_record_const.new()
	
func _init(p_databases).(p_databases):
	pass