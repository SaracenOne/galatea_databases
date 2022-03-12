@tool
extends "./generic_database.gd"

const actor_group_record_const = preload("actor_group_record.gd")

const DATABASE_IDENT = "AGRP"
const DATABASE_NAME = "actor_group_database"
const DATABASE_NAME_JSON = "actor_group_database.json"
const DATABASE_INLINED_FILENAME = "actor_group_database_inlined.gd"
const RECORDS_NAME = "actor_group_records"
	
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
	return actor_group_record_const.new()
	
func _init(p_databases):
	super._init(p_databases)
