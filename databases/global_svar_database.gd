const generic_database_const = preload("generic_database.gd")

const SVAR_TYPE_INTEGER = 0
const SVAR_TYPE_FLOAT = 1
const SVAR_TYPE_STRING = 2

static func get_array_of_types_as_strings():
	return ["integer", "float", "string"]

class GlobalSvarDatabase:
	extends "generic_database.gd".GenericDatabase
	
	const DATABASE_IDENT = "SVAR"
	const DATABASE_NAME = "global_svar_database"
	const DATABASE_NAME_JSON = "global_svar_database.json"
	const DATABASE_NAME_BINARY = "global_svar_database.gdb"
	const DATABASE_INLINED_FILENAME = "global_svar_database_inlined.gd"
	const RECORDS_NAME = "global_svar_records"
		
	static func svar_type_to_string(p_type):
		if(p_type == SVAR_TYPE_INTEGER):
			return "integer"
		elif(p_type == SVAR_TYPE_FLOAT):
			return "float"
		elif(p_type == SVAR_TYPE_STRING):
			return "string"
		else:
			return ""
			
	static func string_to_svar_type(p_string):
		if(p_string == "integer"):
			return SVAR_TYPE_INTEGER
		elif(p_string == "float"):
			return SVAR_TYPE_FLOAT
		elif(p_string == "string"):
			return SVAR_TYPE_STRING
		else:
			return SVAR_TYPE_INTEGER
	
	class GlobalSVarRecord:
		extends "generic_database.gd".GenericRecord
		
		var type = SVAR_TYPE_INTEGER
		var value = 0
		
	func get_database_name():
		return DATABASE_NAME
		
	func get_inlined_filename():
		return DATABASE_INLINED_FILENAME
		
	func load_database_ids():
		return _load_database_ids(databases.path + "/" + DATABASE_NAME_JSON, RECORDS_NAME)
		
	func _load_record(p_dictionary_record, p_database_record):
		# Read Data
		._load_record(p_dictionary_record, p_database_record)
			
		if(p_dictionary_record.has("type")):
			p_database_record.type = string_to_svar_type(p_dictionary_record.type)
			
		if(p_database_record.type == SVAR_TYPE_INTEGER):
			p_database_record.value = int(p_dictionary_record.value)
		elif(p_database_record.type == SVAR_TYPE_FLOAT):
			p_database_record.value = float(p_dictionary_record.value)
		elif(p_database_record.type == SVAR_TYPE_STRING):
			p_database_record.value = str(p_dictionary_record.value)
			
	func load_database_values():
		_load_database_values(databases.path + "/" + DATABASE_NAME_JSON, RECORDS_NAME)
		
	func _save_record(p_database_record, p_dictionary_record):
		# Write Data
		._save_record(p_database_record, p_dictionary_record)
		
		p_dictionary_record.type = svar_type_to_string(p_database_record.type)
			
		if(p_database_record.type == SVAR_TYPE_INTEGER):
			p_dictionary_record.value = int(p_database_record.value)
		elif(p_database_record.type == SVAR_TYPE_FLOAT):
			p_dictionary_record.value = float(p_database_record.value)
		elif(p_database_record.type == SVAR_TYPE_STRING):
			p_dictionary_record.value = str(p_database_record.value)
		
	func save_database():
		_save_database(databases.path + "/" + DATABASE_NAME_JSON, RECORDS_NAME)
			
	func _create_record():
		return GlobalSVarRecord.new()
		
	func _init(p_databases).(p_databases):
		pass