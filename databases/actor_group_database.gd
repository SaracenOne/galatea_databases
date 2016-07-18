const generic_database_const = preload("generic_database.gd")

class ActorGroupDatabase:
	extends "generic_database.gd".GenericDatabase
	
	const DATABASE_IDENT = "AGRP"
	const DATABASE_NAME = "actor_group_database"
	const DATABASE_NAME_JSON = "actor_group_database.json"
	const DATABASE_NAME_BINARY = "actor_group_database.gbd"
	const DATABASE_INLINED_FILENAME = "actor_group_database_inlined.gd"
	const RECORDS_NAME = "actor_group_records"
	
	class ActorGroupRecord:
		extends "generic_database.gd".GenericRecord
		
		var printed_name = ""
		var description = ""
		var main_icon_path = ""
		
	func get_database_name():
		return DATABASE_NAME
		
	func get_inlined_filename():
		return DATABASE_INLINED_FILENAME
		
	func load_database_ids():
		return _load_database_ids(databases.path + "/" + DATABASE_NAME_JSON, RECORDS_NAME)
		
	func _load_record(p_dictionary_record, p_database_record):
		# Read Data
		._load_record(p_dictionary_record, p_database_record)
		
		if(p_dictionary_record.has("printed_name")):
			p_database_record.printed_name = p_dictionary_record.printed_name
			
		if(p_dictionary_record.has("description")):
			p_database_record.description = p_dictionary_record.description
			
		if(p_dictionary_record.has("main_icon_path")):
			p_database_record.main_icon_path = p_dictionary_record.main_icon_path
		
	func load_database_values():
		_load_database_values(databases.path + "/" + DATABASE_NAME_JSON, RECORDS_NAME)
		
	func _save_record(p_database_record, p_dictionary_record):
		# Write Data
		._save_record(p_database_record, p_dictionary_record)
		
		p_dictionary_record.printed_name = p_database_record.printed_name
		p_dictionary_record.description = p_database_record.description
		p_dictionary_record.main_icon_path = p_database_record.main_icon_path
		
	func save_database():
		_save_database(databases.path + "/" + DATABASE_NAME_JSON, RECORDS_NAME)
			
	func _create_record():
		return ActorGroupRecord.new()
		
	func _init(p_databases).(p_databases):
		pass