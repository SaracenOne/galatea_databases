const generic_database_const = preload("generic_database.gd")

class HairDatabase:
	extends "generic_database.gd".GenericDatabase

	const DATABASE_NAME = "hair_database.json"
	const RECORDS_NAME = "hair_records"
	
	class HairRecord:
		extends "generic_database.gd".GenericRecord
		
		var hair_model = ""
		
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
		return HairRecord.new()
		
	func _init(p_databases).(p_databases):
		pass