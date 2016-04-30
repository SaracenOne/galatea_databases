const generic_database_const = preload("generic_database.gd")

class MaterialTypeDatabase:
	extends "generic_database.gd".GenericDatabase

	const DATABASE_NAME = "material_type_database.json"
	const RECORDS_NAME = "material_type_records"
	
	class MaterialTypeRecord:
		extends "generic_database.gd".GenericRecord
		
	func load_database_ids():
		return _load_database_ids(databases.path + "/" + DATABASE_NAME, RECORDS_NAME)
		
	func load_database_values():
		_load_database_values(databases.path + "/" + DATABASE_NAME, RECORDS_NAME)
			
	func _save_record(p_database_record, p_dictionary_record):
		# Write Data
		._save_record(p_database_record, p_dictionary_record)
		
	func save_database():
		_save_database(databases.path + "/" + DATABASE_NAME, RECORDS_NAME)
			
	func _create_record():
		return MaterialTypeRecord.new()
		
	func _init(p_databases).(p_databases):
		pass