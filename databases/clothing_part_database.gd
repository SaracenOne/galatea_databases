extends "generic_database.gd"

const generic_database_const = preload("generic_database.gd")
const clothing_part_record_const = preload("clothing_part_record.gd")

const DATABASE_IDENT = "CLPT"
const DATABASE_NAME = "clothing_part_database"
const DATABASE_NAME_JSON = "clothing_part_database.json"
const DATABASE_NAME_BINARY = "clothing_part_database.gbd"
const DATABASE_INLINED_FILENAME = "clothing_part_database_inlined.gd"
const RECORDS_NAME = "clothing_part_records"

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
	return clothing_part_record_const.new()

func _init(p_databases).(p_databases):
	pass