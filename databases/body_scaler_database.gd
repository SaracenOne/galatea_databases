extends "generic_database.gd"

const generic_database_const = preload("generic_database.gd")
const body_scaler_record_const = preload("body_scaler_record.gd")

const DATABASE_IDENT = "BSCL"
const DATABASE_NAME = "body_scaler_database"
const DATABASE_NAME_JSON = "body_scaler_database.json"
const DATABASE_NAME_BINARY = "body_scaler_database.gbd"
const DATABASE_INLINED_FILENAME = "body_scaler_database_inlined.gd"
const RECORDS_NAME = "body_scaler_records"

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
	return body_scaler_record_const.new()
		
func _init(p_databases).(p_databases):
	pass