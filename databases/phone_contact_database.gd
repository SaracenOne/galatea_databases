const generic_database_const = preload("generic_database.gd")

class PhoneContactDatabase:
	extends "generic_database.gd".GenericDatabase
	
	const DATABASE_IDENT = "PCON"
	const DATABASE_NAME = "phone_contact_database.json"
	const DATABASE_NAME_BINARY = "phone_contact_database.gbd"
	const RECORDS_NAME = "phone_contact_records"
	
	class PhoneContactRecord:
		extends "generic_database.gd".GenericRecord
		
		var associated_actor = null
		var contact_image_path = ""
		
		var appears_in_contacts_list = false
		var removable_from_contacts_list = false
		
		var can_phone = false
		var can_draft_messages = false
		
		var phone_use_label = ""
		var draft_message_label = ""
		
	func load_database_ids():
		return _load_database_ids(databases.path + "/" + DATABASE_NAME, RECORDS_NAME)
		
	func _load_record(p_dictionary_record, p_database_record):
		# Read Data
		._load_record(p_dictionary_record, p_database_record)
		
	func load_database_values():
		_load_database_values(databases.path + "/" + DATABASE_NAME, RECORDS_NAME)
		
	func _save_record(p_database_record, p_dictionary_record):
		# Write Data
		._save_record(p_database_record, p_dictionary_record)
		
	func save_database():
		_save_database(databases.path + "/" + DATABASE_NAME, RECORDS_NAME)
			
	func _create_record():
		return PhoneContactRecord.new()
		
	func _init(p_databases).(p_databases):
		pass