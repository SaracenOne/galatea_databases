extends "generic_record.gd"

const generic_database_const = preload("generic_database.gd")

var texture_set = null
var target_min = Vector2(0.0, 0.0)
var target_max = Vector2(1.0, 1.0)
var uses_alpha = false
var invert_alpha = false

func _load_record(p_dictionary_record, p_databases):
	# Read Data
	._load_record(p_dictionary_record, p_databases)

	if(p_dictionary_record.has("texture_set")):
		texture_set = p_databases.texture_set_database.find_record_by_name(p_dictionary_record.texture_set)
	else:
		texture_set = null

	if(p_dictionary_record.has("target_min")):
		target_min = generic_database_const.convert_string_to_vector_2(p_dictionary_record.target_min)

	if(p_dictionary_record.has("target_max")):
		target_max = generic_database_const.convert_string_to_vector_2(p_dictionary_record.target_max)
		
	if(p_dictionary_record.has("uses_alpha")):
		uses_alpha = uses_alpha
		
	if(p_dictionary_record.has("invert_alpha")):
		invert_alpha = invert_alpha

func _save_record(p_dictionary_record, p_databases):
	# Write Data
	._save_record(p_dictionary_record, p_databases)
	if(texture_set):
		p_dictionary_record.texture_set = texture_set.id
	else:
		p_dictionary_record.texture_set = ""

	p_dictionary_record.target_min = target_min
	p_dictionary_record.target_max = target_max
	p_dictionary_record.uses_alpha = uses_alpha
	p_dictionary_record.invert_alpha = invert_alpha