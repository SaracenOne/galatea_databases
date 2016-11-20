extends "generic_record.gd"

const generic_database_const = preload("generic_database.gd")

enum {HEADPART_HEAD,
 HEADPART_EYES,
 HEADPART_EYEBROWS,
 HEADPART_MOUTH,
 HEADPART_EYELASHES,
 HEADPART_MAX}

var headpart_type = HEADPART_HEAD
var mesh_path = ""
var gen_morph_path = ""
var stamp = null

var target_min = Vector2(0.0, 0.0)
var target_max = Vector2(1.0, 1.0)

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
		
	if(p_dictionary_record.has("mesh_path")):
		mesh_path = p_dictionary_record.mesh_path
		
	if(p_dictionary_record.has("gen_morph_path")):
		gen_morph_path = p_dictionary_record.gen_morph_path
		
	if(p_dictionary_record.has("stamp")):
		stamp = p_databases.stamp_database.find_record_by_name(p_dictionary_record.stamp)
		
	if(p_dictionary_record.has("target_min")):
		target_min = generic_database_const.convert_string_to_vector_2(p_dictionary_record.target_min)

	if(p_dictionary_record.has("target_max")):
		target_max = generic_database_const.convert_string_to_vector_2(p_dictionary_record.target_max)
	
func _save_record(p_dictionary_record, p_databases):
	# Write Data
	._save_record(p_dictionary_record, p_databases)
	
	p_dictionary_record.headpart_type = get_string_from_headpart(headpart_type)
	p_dictionary_record.mesh_path = mesh_path
	p_dictionary_record.gen_morph_path = gen_morph_path
	
	if(stamp):
		p_dictionary_record.stamp = stamp.id
		
	p_dictionary_record.target_min = target_min
	p_dictionary_record.target_max = target_max
	
func is_headpart_type(p_type):
	return headpart_type == p_type