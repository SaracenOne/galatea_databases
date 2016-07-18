const generic_database_const = preload("generic_database.gd")

class ActivityDatabase:
	extends "generic_database.gd".GenericDatabase

	const DATABASE_IDENT = "ACTV"
	const DATABASE_NAME = "activity_database"
	const DATABASE_NAME_JSON = "activity_database.json"
	const DATABASE_NAME_BINARY = "activity_database.gbd"
	const DATABASE_INLINED_FILENAME = "activity_database_inlined.gd"
	const RECORDS_NAME = "activity_records"
	
	class ActivityRecord:
		extends "generic_database.gd".GenericRecord
		
		var printed_name = ""
		var description = ""
		var main_icon_path = ""
		
		var activity_script_path = ""
		var valid_locations = []
		
		var selectable = false
		
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
			
		if(p_dictionary_record.has("activity_script_path")):
			p_database_record.activity_script_path = p_dictionary_record.activity_script_path
			
		if(p_dictionary_record.has("valid_locations")):
			for valid_location in p_dictionary_record.valid_locations:
				var location = databases.location_database.find_record_by_name(valid_location)
				if(location != null):
					p_database_record.valid_locations.append(location)
					
		if(p_dictionary_record.has("selectable")):
			p_database_record.selectable = p_dictionary_record.selectable
		
	func load_database_values():
		_load_database_values(databases.path + "/" + DATABASE_NAME_JSON, RECORDS_NAME)
		
	func _save_record(p_database_record, p_dictionary_record):
		# Write Data
		._save_record(p_database_record, p_dictionary_record)
		
		p_dictionary_record.printed_name = p_database_record.printed_name
		p_dictionary_record.description = p_database_record.description
		p_dictionary_record.main_icon_path = p_database_record.main_icon_path
		
		p_dictionary_record.activity_script_path = p_database_record.activity_script_path
		
		p_dictionary_record.valid_locations = []
		for valid_location in p_database_record.valid_locations:
			p_dictionary_record.valid_locations.append(valid_location.id)
			
		p_dictionary_record.selectable = p_database_record.selectable
		
	func save_database():
		_save_database(databases.path + "/" + DATABASE_NAME_JSON, RECORDS_NAME)
			
	func _create_record():
		return ActivityRecord.new()
		
	func _init(p_databases).(p_databases):
		pass
		