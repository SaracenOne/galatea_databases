@tool
extends "./generic_database.gd"

const stamp_record_const = preload("stamp_record.gd")

const DATABASE_IDENT = "STMP"
const DATABASE_NAME = "stamp_database"
const DATABASE_NAME_JSON = "stamp_database.json"
const DATABASE_INLINED_FILENAME = "stamp_database_inlined.gd"
const RECORDS_NAME = "stamp_records"

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
	return stamp_record_const.new()

func _init(p_databases):
	super._init(p_databases)
