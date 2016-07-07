const generic_database_const = preload("generic_database.gd")

class SMSDatabase:
	extends "generic_database.gd".GenericDatabase
	
	const DATABASE_IDENT = "SMSD"
	const DATABASE_NAME = "sms_database.json"
	const DATABASE_NAME_BINARY = "sms_database.gbd"
	const RECORDS_NAME = "sms_records"

	class SMSRecord:
		extends "generic_database.gd".GenericRecord
		var actor = null
		var is_reply = false
		var message_body = ""
		
	func load_database_ids():
		return _load_database_ids(databases.path + "/" + DATABASE_NAME, RECORDS_NAME)
		
	func _load_record(p_dictionary_record, p_database_record):
		# Read Data
		._load_record(p_dictionary_record, p_database_record)
		
		if(p_dictionary_record.has("actor")):
			var actor = databases.actor_database.find_record_by_name(p_dictionary_record.actor)
			if(actor != null):
				p_database_record.actor = actor
				
		if(p_dictionary_record.has("is_reply")):
			p_database_record.is_reply = p_dictionary_record.is_reply
		if(p_dictionary_record.has("message_body")):
			p_database_record.message_body = p_dictionary_record.message_body
		
	func load_database_values():
		_load_database_values(databases.path + "/" + DATABASE_NAME, RECORDS_NAME)
		
	func _save_record(p_database_record, p_dictionary_record):
		# Write Data
		._save_record(p_database_record, p_dictionary_record)
		
		p_dictionary_record.actor = p_database_record.actor.id
		p_dictionary_record.is_reply = p_database_record.is_reply
		p_dictionary_record.message_body = p_database_record.message_body
		
	func save_database():
		_save_database(databases.path + "/" + DATABASE_NAME, RECORDS_NAME)
			
	func _create_record():
		return SMSRecord.new()
		
	func _init(p_databases).(p_databases):
		pass