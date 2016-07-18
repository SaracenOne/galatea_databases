const generic_database_const = preload("generic_database.gd")

class BodyScalerDatabase:
	extends "generic_database.gd".GenericDatabase
	
	const DATABASE_IDENT = "BSCL"
	const DATABASE_NAME = "body_scaler_database"
	const DATABASE_NAME_JSON = "body_scaler_database.json"
	const DATABASE_NAME_BINARY = "body_scaler_database.gbd"
	const DATABASE_INLINED_FILENAME = "body_scaler_database_inlined.gd"
	const RECORDS_NAME = "body_scaler_records"
	
	class BodyScalerRecord:
		extends "generic_database.gd".GenericRecord
		
		class BoneScaler:
			var bone_name=""
			var inverse=false
			var scale=Vector3()
			
			func parse_bone_scaler():
				pass
			
		var body_scaler_name = ""
		var body_scaler_printed_name = ""
		
		var is_hidden=false
		
		var bone_scalers = []
		
		func parse_body_scaler():
			pass
			
	func get_database_name():
		return DATABASE_NAME
			
	func get_inlined_filename():
		return DATABASE_INLINED_FILENAME
			
	func load_database_ids():
		return _load_database_ids(databases.path + "/" + DATABASE_NAME_JSON, RECORDS_NAME)
		
	func _load_record(p_dictionary_record, p_database_record):
		# Read Data
		._load_record(p_dictionary_record, p_database_record)
		
	func load_database_values():
		_load_database_values(databases.path + "/" + DATABASE_NAME_JSON, RECORDS_NAME)
		
	func _save_record(p_database_record, p_dictionary_record):
		# Write Data
		._save_record(p_database_record, p_dictionary_record)
		
	func save_database():
		_save_database(databases.path + "/" + DATABASE_NAME_JSON, RECORDS_NAME)
		
	func _create_record():
		return BodyScalerRecord.new()
			
	func _init(p_databases).(p_databases):
		pass