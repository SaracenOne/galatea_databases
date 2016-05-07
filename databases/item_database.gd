const generic_database_const = preload("generic_database.gd")

const ITEM_TYPE_UNKNOWN = 0
const ITEM_TYPE_MISC = 1
const ITEM_TYPE_KEY = 2
const ITEM_TYPE_CONSUMABLE = 3

class ItemRecord:
	extends "generic_database.gd".GenericRecord
	var printed_name = ""
	var description = ""
	var item_type = ITEM_TYPE_UNKNOWN
	var pickup_sfx = ""
	var putdown_sfx = ""

class ItemDatabase:
	extends "generic_database.gd".GenericDatabase
	
	const DATABASE_IDENT = "ITEM"
	const DATABASE_NAME = "item_database.json"
	const DATABASE_NAME_BINARY = "item_database.gbd"
	const RECORDS_NAME = "item_records"
	
	func load_database_ids():
		return _load_database_ids(databases.path + "/" + DATABASE_NAME, RECORDS_NAME)
			
	func _load_record(p_dictionary_record, p_database_record):
		# Read Data
		._load_record(p_dictionary_record, p_database_record)
		
		if(p_dictionary_record.has("printed_name")):
			p_database_record.printed_name = p_dictionary_record.printed_name
			
		if(p_dictionary_record.has("description")):
			p_database_record.description = p_dictionary_record.description
		
		if(p_dictionary_record.has("item_type")):
			if(p_dictionary_record.item_type == "misc"):
				p_database_record.item_type = ITEM_TYPE_MISC
			elif(p_dictionary_record.item_type == "key"):
				p_database_record.item_type = ITEM_TYPE_KEY
			elif(p_dictionary_record.item_type == "consumable"):
				p_database_record.item_type = ITEM_TYPE_CONSUMABLE
			else:
				p_database_record.item_type = ITEM_TYPE_UNKNOWN
		
		if(p_dictionary_record.has("pickup_sfx")):
			p_database_record.pickup_sfx = p_dictionary_record.pickup_sfx
			
		if(p_dictionary_record.has("putdown_sfx")):
			p_database_record.putdown_sfx = p_dictionary_record.putdown_sfx
		
	func load_database_values():
		_load_database_values(databases.path + "/" + DATABASE_NAME, RECORDS_NAME)
		
	func _save_record(p_database_record, p_dictionary_record):
		# Write Data
		._save_record(p_database_record, p_dictionary_record)
		
		p_dictionary_record.printed_name = p_database_record.printed_name
		p_dictionary_record.description = p_database_record.description
		
		if(p_database_record.item_type == ITEM_TYPE_MISC):
			p_dictionary_record.item_type = "misc"
		elif(p_database_record.item_type == ITEM_TYPE_KEY):
			p_dictionary_record.item_type = "key"
		elif(p_database_record.item_type == ITEM_TYPE_CONSUMABLE):
			p_dictionary_record.item_type = "consumable"
		else:
			p_dictionary_record.item_type = "???"
		
		p_dictionary_record.pickup_sfx = p_database_record.pickup_sfx
		p_dictionary_record.putdown_sfx = p_database_record.putdown_sfx
		
	func save_database():
		_save_database(databases.path + "/" + DATABASE_NAME, RECORDS_NAME)
			
	func _create_record():
		return ItemRecord.new()
		
	func _init(p_databases).(p_databases):
		pass