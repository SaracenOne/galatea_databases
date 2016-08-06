extends "generic_database.gd"

const generic_database_const = preload("generic_database.gd")
const school_lesson_record_const = preload("school_lesson_record.gd")

const DATABASE_IDENT = "SCLS"
const DATABASE_NAME = "school_lesson_database"
const DATABASE_NAME_JSON = "school_lesson_database.json"
const DATABASE_NAME_BINARY = "school_lesson_database.gbd"
const DATABASE_INLINED_FILENAME = "school_lesson_database_inlined.gd"
const RECORDS_NAME = "school_lesson_records"
	
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
	return school_lesson_record_const.new()
	
func _init(p_databases).(p_databases):
	pass