const generic_database_const = preload("generic_database.gd")

const ITEM_TYPE_UNKNOWN = 0
const ITEM_TYPE_MISC = 1
const ITEM_TYPE_KEY = 2
const ITEM_TYPE_CONSUMABLE = 3

class ItemRecord:
	extends "generic_database.gd".GenericRecord
	var printed_name = ""
	var description = ""
	var value = 0
	var item_type = ITEM_TYPE_UNKNOWN
	var icon_path = ""
	var pickup_sfx = ""
	var putdown_sfx = ""
	var can_gift = false

class ItemDatabase:
	extends "generic_database.gd".GenericDatabase
	
	const DATABASE_IDENT = "ITEM"
	const DATABASE_NAME = "item_database"
	const DATABASE_NAME_JSON = "item_database.json"
	const DATABASE_NAME_BINARY = "item_database.gbd"
	const DATABASE_INLINED_FILENAME = "item_database_inlined.gd"
	const RECORDS_NAME = "item_records"
	
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
			
		if(p_dictionary_record.has("value")):
			p_database_record.value = p_dictionary_record.value
		
		if(p_dictionary_record.has("item_type")):
			if(p_dictionary_record.item_type == "misc"):
				p_database_record.item_type = ITEM_TYPE_MISC
			elif(p_dictionary_record.item_type == "key"):
				p_database_record.item_type = ITEM_TYPE_KEY
			elif(p_dictionary_record.item_type == "consumable"):
				p_database_record.item_type = ITEM_TYPE_CONSUMABLE
			else:
				p_database_record.item_type = ITEM_TYPE_UNKNOWN
		
		if(p_dictionary_record.has("icon_path")):
			p_database_record.icon_path = p_dictionary_record.icon_path
		
		if(p_dictionary_record.has("pickup_sfx")):
			p_database_record.pickup_sfx = p_dictionary_record.pickup_sfx
			
		if(p_dictionary_record.has("putdown_sfx")):
			p_database_record.putdown_sfx = p_dictionary_record.putdown_sfx
			
		if(p_dictionary_record.has("can_gift")):
			p_database_record.can_gift = p_dictionary_record.can_gift
		
	func load_database_values():
		_load_database_values(databases.path + "/" + DATABASE_NAME_JSON, RECORDS_NAME)
		
	func _save_record(p_database_record, p_dictionary_record):
		# Write Data
		._save_record(p_database_record, p_dictionary_record)
		
		p_dictionary_record.printed_name = p_database_record.printed_name
		p_dictionary_record.description = p_database_record.description
		p_dictionary_record.value = p_database_record.value
		
		if(p_database_record.item_type == ITEM_TYPE_MISC):
			p_dictionary_record.item_type = "misc"
		elif(p_database_record.item_type == ITEM_TYPE_KEY):
			p_dictionary_record.item_type = "key"
		elif(p_database_record.item_type == ITEM_TYPE_CONSUMABLE):
			p_dictionary_record.item_type = "consumable"
		else:
			p_dictionary_record.item_type = "???"
		
		p_dictionary_record.icon_path = p_database_record.icon_path
		p_dictionary_record.pickup_sfx = p_database_record.pickup_sfx
		p_dictionary_record.putdown_sfx = p_database_record.putdown_sfx
		p_dictionary_record.can_gift = p_database_record.can_gift
		
	func save_database():
		_save_database(databases.path + "/" + DATABASE_NAME_JSON, RECORDS_NAME)
			
	func _create_record():
		return ItemRecord.new()
		
	func _init(p_databases).(p_databases):
		pass