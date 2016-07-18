const generic_database_const = preload("generic_database.gd")
const date_and_time_const = preload("res://addons/date_and_time/date_and_time.gd")
#
class LocationDatabase:
	extends "generic_database.gd".GenericDatabase
	
	const DATABASE_IDENT = "LOCT"
	const DATABASE_NAME = "location_database"
	const DATABASE_NAME_JSON = "location_database.json"
	const DATABASE_NAME_BINARY = "location_database.gbd"
	const DATABASE_INLINED_FILENAME = "location_database_inlined.gd"
	const RECORDS_NAME = "location_records"
	
	class LocationRecord:
		extends "generic_database.gd".GenericRecord
		
		var printed_name = ""
		var scene_path = ""
		
		var maximum_actor_capacity = -1
		var maximum_actor_capacity_includes_players = false
		
		class LinkedLocationData:
			var location = null
			var distance = 0.0
		
		var linked_locations = []
		
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
			
		if(p_dictionary_record.has("scene_path")):
			p_database_record.scene_path = p_dictionary_record.scene_path
		
		if(p_dictionary_record.has("maximum_actor_capacity")):
			p_database_record.maximum_actor_capacity = p_dictionary_record.maximum_actor_capacity
		if(p_dictionary_record.has("maximum_actor_capacity_includes_players")):
			p_database_record.maximum_actor_capacity_includes_players = p_dictionary_record.maximum_actor_capacity_includes_players
				
	func load_database_values():
		_load_database_values(databases.path + "/" + DATABASE_NAME_JSON, RECORDS_NAME)
			
	func _save_record(p_database_record, p_dictionary_record):
		# Write Data
		._save_record(p_database_record, p_dictionary_record)
		
		p_dictionary_record.printed_name = p_database_record.printed_name
		p_dictionary_record.scene_path = p_database_record.scene_path
		p_dictionary_record.maximum_actor_capacity = p_database_record.maximum_actor_capacity
		p_dictionary_record.maximum_actor_capacity_includes_players = p_database_record.maximum_actor_capacity_includes_players
		
	func save_database():
		_save_database(databases.path + "/" + DATABASE_NAME_JSON, RECORDS_NAME)
			
	func _create_record():
		return LocationRecord.new()
		
	func _init(p_databases).(p_databases):
		pass