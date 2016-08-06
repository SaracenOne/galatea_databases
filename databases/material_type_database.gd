extends "generic_database.gd"

const generic_database_const = preload("generic_database.gd")
const material_type_record_const = preload("material_type_record.gd")

const DATABASE_IDENT = "MATT"
const DATABASE_NAME = "material_type_database"
const DATABASE_NAME_JSON = "material_type_database.json"
const DATABASE_NAME_BINARY = "material_type_database.gbd"
const DATABASE_INLINED_FILENAME = "material_type_database_inlined.gd"
const RECORDS_NAME = "material_type_records"
	
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
	return material_type_record_const.new()
	
func _init(p_databases).(p_databases):
	pass