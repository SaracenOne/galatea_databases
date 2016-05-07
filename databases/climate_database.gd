const generic_database_const = preload("generic_database.gd")

class ClimateDatabase:
	extends "generic_database.gd".GenericDatabase
	
	const DATABASE_IDENT = "CLIM"
	const DATABASE_NAME = "climate_database.json"
	const DATABASE_NAME_BINARY = "climate_database.gbd"
	const RECORDS_NAME = "climate_set_records"

	class ClimateRecord:
		extends "generic_database.gd".GenericRecord
		var weather_list = []
		
	func load_database_ids():
		return _load_database_ids(databases.path + "/" + DATABASE_NAME, RECORDS_NAME)
		
	func _load_record(p_dictionary_record, p_database_record):
		# Read Data
		._load_record(p_dictionary_record, p_database_record)
		
	func load_database_values():
		_load_database_values(databases.path + "/" + DATABASE_NAME, RECORDS_NAME)
		
	func _save_record(p_database_record, p_dictionary_record):
		# Write Data
		._save_record(p_database_record, p_dictionary_record)
		
	func save_database():
		_save_database(databases.path + "/" + DATABASE_NAME, RECORDS_NAME)
			
	func _create_record():
		return ClimateRecord.new()
		
	func _init(p_databases).(p_databases):
		pass