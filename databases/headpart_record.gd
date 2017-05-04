extends "generic_record.gd"

const generic_database_const = preload("generic_database.gd")

enum {HEADPART_HEAD,
 HEADPART_EYES,
 HEADPART_EYEBROWS,
 HEADPART_MOUTH,
 HEADPART_EYELASHES,
 HEADPART_MAX}

export(int) var headpart_type = HEADPART_HEAD
export(Resource) var meshpart = null
export(Resource) var stamp = null
export(String) var main_icon_path = ""
export(bool) var character_creator = false

static func get_headpart_from_string(p_string):
	var lower_string = p_string.to_lower()
	
	if(lower_string == "head"):
		return HEADPART_HEAD
	elif(lower_string == "eyes"):
		return HEADPART_EYES
	elif(lower_string == "eyebrows"):
		return HEADPART_EYEBROWS
	elif(lower_string == "mouth"):
		return HEADPART_MOUTH
	elif(lower_string == "eyelashes"):
		return HEADPART_EYELASHES
	else:
		return HEADPART_HEAD
		
static func get_string_from_headpart(p_headpart_type):
	if(p_headpart_type == HEADPART_HEAD):
		return "head"
	elif(p_headpart_type == HEADPART_EYES):
		return "eyes"
	elif(p_headpart_type == HEADPART_EYEBROWS):
		return "eyebrows"
	elif(p_headpart_type == HEADPART_MOUTH):
		return "mouth"
	elif(p_headpart_type == HEADPART_EYELASHES):
		return "eyelashes"
	else:
		""

func _load_record(p_dictionary_record, p_databases):
	# Read Data
	._load_record(p_dictionary_record, p_databases)
	
	if(p_dictionary_record.has("headpart_type")):
		headpart_type = get_headpart_from_string(p_dictionary_record.headpart_type)
		
	if(p_dictionary_record.has("meshpart")):
		meshpart = p_databases.meshpart_database.find_record_by_name(p_dictionary_record.meshpart)
	else:
		meshpart = null
		
	if(p_dictionary_record.has("stamp")):
		stamp = p_databases.stamp_database.find_record_by_name(p_dictionary_record.stamp)
		
	if(p_dictionary_record.has("main_icon_path")):
		main_icon_path = p_dictionary_record.main_icon_path
		
	if(p_dictionary_record.has("character_creator")):
		character_creator = p_dictionary_record.character_creator
	
func _save_record(p_dictionary_record, p_databases):
	# Write Data
	._save_record(p_dictionary_record, p_databases)
	
	p_dictionary_record.headpart_type = get_string_from_headpart(headpart_type)
	if(meshpart):
		p_dictionary_record.meshpart = meshpart.id
	
	if(stamp):
		p_dictionary_record.stamp = stamp.id
		
	p_dictionary_record.main_icon_path = main_icon_path
		
	p_dictionary_record.character_creator = character_creator
	
func is_headpart_type(p_type):
	return headpart_type == p_type