const generic_database_const = preload("generic_database.gd")

class QuestDatabase:
	extends "generic_database.gd".GenericDatabase
	
	const DATABASE_IDENT = "QUST"
	const DATABASE_NAME = "quest_database"
	const DATABASE_NAME_JSON = "quest_database.json"
	const DATABASE_NAME_BINARY = "quest_database.gbd"
	const DATABASE_INLINED_FILENAME = "quest_database_inlined.gd"
	const RECORDS_NAME = "quest_records"
		
	class QuestRecord:
		extends "generic_database.gd".GenericRecord
		
		var printed_name = ""
		var invisible = true
		var autostart = false
		
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
			
		if(p_dictionary_record.has("invisible")):
			p_database_record.invisible = p_dictionary_record.invisible
		
	func load_database_values():
		_load_database_values(databases.path + "/" + DATABASE_NAME_JSON, RECORDS_NAME)
		
	func _save_record(p_database_record, p_dictionary_record):
		# Write Data
		._save_record(p_database_record, p_dictionary_record)
		
	func save_database():
		_save_database(databases.path + "/" + DATABASE_NAME_JSON, RECORDS_NAME)
			
	func _create_record():
		return QuestRecord.new()
		
	func _init(p_databases).(p_databases):
		pass