const item_database_const = preload("item_database.gd")

class ReadableDatabase:
	extends "item_database.gd".ItemDatabase
	
	const DATABASE_IDENT = "READ"
	const DATABASE_NAME = "readable_database.json"
	const DATABASE_NAME_BINARY = "readable_database.gbd"
	const RECORDS_NAME = "readable_records"
	
	class ReadableRecord:
		extends "item_database.gd".ItemRecord
		var readable_text = ""
			
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
		return ReadableRecord.new()
		
	func _init(p_databases).(p_databases):
		pass