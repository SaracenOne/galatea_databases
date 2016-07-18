const generic_database_const = preload("generic_database.gd")

class TraitDatabase:
	extends "generic_database.gd".GenericDatabase
	
	const DATABASE_IDENT = "TRAT"
	const DATABASE_NAME = "trait_database"
	const DATABASE_NAME_JSON = "trait_database.json"
	const DATABASE_NAME_BINARY = "trait_database.gbd"
	const DATABASE_INLINED_FILENAME = "trait_database_inlined.gd"
	const RECORDS_NAME = "trait_records"
	
	class TraitRecord:
		extends "generic_database.gd".GenericRecord
		
		var printed_name = ""
		var description = ""
		var main_icon_path = ""
		
		var visible_in_character_creator = false
		
		var contradictory_traits = []
		
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
			
		if(p_dictionary_record.has("visible_in_character_creator")):
			p_database_record.visible_in_character_creator = p_dictionary_record.visible_in_character_creator
			
		if(p_dictionary_record.has("contradictory_traits")):
			for contradictory_trait_name in p_dictionary_record.contradictory_traits:
				var contradictory_trait = find_record_by_name(contradictory_trait_name)
				if(contradictory_trait != null):
					p_database_record.contradictory_traits.append(contradictory_trait)
		
	func load_database_values():
		_load_database_values(databases.path + "/" + DATABASE_NAME_JSON, RECORDS_NAME)
		
	func _save_record(p_database_record, p_dictionary_record):
		# Write Data
		._save_record(p_database_record, p_dictionary_record)
		
		p_dictionary_record.printed_name = p_database_record.printed_name
		p_dictionary_record.description = p_database_record.description
		p_dictionary_record.main_icon_path = p_database_record.main_icon_path
		p_dictionary_record.visible_in_character_creator = p_database_record.visible_in_character_creator
		
		p_dictionary_record.contradictory_traits = []
		for contradictory_trait in p_database_record.contradictory_traits:
			p_dictionary_record.contradictory_traits.append(contradictory_trait.id)#
		
	func save_database():
		_save_database(databases.path + "/" + DATABASE_NAME_JSON, RECORDS_NAME)
			
	func _create_record():
		return TraitRecord.new()
		
	func _init(p_databases).(p_databases):
		pass