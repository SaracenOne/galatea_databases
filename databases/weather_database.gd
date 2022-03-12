@tool
extends "./generic_database.gd"

const weather_record_const = preload("weather_record.gd")

const DATABASE_IDENT = "WEAT"
const DATABASE_NAME = "weather_database"
const DATABASE_NAME_JSON = "weather_database.json"
const DATABASE_INLINED_FILENAME = "weather_database_inlined.gd"
const RECORDS_NAME = "weather_set_records"

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
	return weather_record_const.new()
	
func _init(p_databases):
	super._init(p_databases)
