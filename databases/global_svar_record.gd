@tool
extends "./generic_record.gd"

const SVAR_TYPE_INTEGER = 0
const SVAR_TYPE_FLOAT = 1
const SVAR_TYPE_STRING = 2
const SVAR_TYPE_BOOLEAN = 3
		
@export var type: int = SVAR_TYPE_INTEGER
@export var value = 0

static func get_array_of_types_as_strings():
	return ["integer", "float", "string", "boolean"]

static func svar_type_to_string(p_type):
	if(p_type == SVAR_TYPE_INTEGER):
		return "integer"
	elif(p_type == SVAR_TYPE_FLOAT):
		return "float"
	elif(p_type == SVAR_TYPE_STRING):
		return "string"
	elif(p_type == SVAR_TYPE_BOOLEAN):
		return "boolean"
	else:
		return ""
		
static func string_to_svar_type(p_string):
	if(p_string == "integer"):
		return SVAR_TYPE_INTEGER
	elif(p_string == "float"):
		return SVAR_TYPE_FLOAT
	elif(p_string == "string"):
		return SVAR_TYPE_STRING
	elif(p_string == "boolean"):
		return SVAR_TYPE_BOOLEAN
	else:
		return SVAR_TYPE_INTEGER

func _load_record(p_dictionary_record, p_databases):
	# Read Data
	super._load_record(p_dictionary_record, p_databases)
		
	if(p_dictionary_record.has("type")):
		type = string_to_svar_type(p_dictionary_record.type)
		
	if(type == SVAR_TYPE_INTEGER):
		value = int(p_dictionary_record.value)
	elif(type == SVAR_TYPE_FLOAT):
		value = float(p_dictionary_record.value)
	elif(type == SVAR_TYPE_STRING):
		value = str(p_dictionary_record.value)
	elif(type == SVAR_TYPE_BOOLEAN):
		value = str(p_dictionary_record.value)
		
func _save_record(p_dictionary_record, p_databases):
	# Write Data
	super._save_record(p_dictionary_record, p_databases)
	
	p_dictionary_record.type = svar_type_to_string(type)
		
	if(type == SVAR_TYPE_INTEGER):
		p_dictionary_record.value = int(value)
	elif(type == SVAR_TYPE_FLOAT):
		p_dictionary_record.value = float(value)
	elif(type == SVAR_TYPE_STRING):
		p_dictionary_record.value = str(value)
	elif(type == SVAR_TYPE_BOOLEAN):
		p_dictionary_record.value = bool(value)
