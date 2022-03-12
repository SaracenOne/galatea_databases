@tool
extends "./generic_database.gd"

const music_track_record_const = preload("music_track_record.gd")

const DATABASE_IDENT = "MUTK"
const DATABASE_NAME = "music_track_database"
const DATABASE_NAME_JSON = "music_track_database.json"
const DATABASE_INLINED_FILENAME = "music_track_database_inlined.gd"
const RECORDS_NAME = "music_track_records"

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
	return music_track_record_const.new()
	
func _init(p_databases):
	super._init(p_databases)
