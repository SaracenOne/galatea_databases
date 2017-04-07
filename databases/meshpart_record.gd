extends "generic_record.gd"

const generic_database_const = preload("generic_database.gd")

export(String) var mesh_path = ""
export(String) var gen_morph_path = ""

export(Vector2) var target_min = Vector2(0.0, 0.0)
export(Vector2) var target_max = Vector2(1.0, 1.0)

func _load_record(p_dictionary_record, p_databases):
	# Read Data
	._load_record(p_dictionary_record, p_databases)

	if(p_dictionary_record.has("mesh_path")):
		mesh_path = p_dictionary_record.mesh_path

	if(p_dictionary_record.has("gen_morph_path")):
		gen_morph_path = p_dictionary_record.gen_morph_path

	if(p_dictionary_record.has("target_min")):
		target_min = generic_database_const.convert_string_to_vector_2(p_dictionary_record.target_min)

	if(p_dictionary_record.has("target_max")):
		target_max = generic_database_const.convert_string_to_vector_2(p_dictionary_record.target_max)

func _save_record(p_dictionary_record, p_databases):
	# Write Data
	._save_record(p_dictionary_record, p_databases)

	p_dictionary_record.mesh_path = mesh_path
	p_dictionary_record.gen_morph_path = gen_morph_path

	p_dictionary_record.target_min = target_min
	p_dictionary_record.target_max = target_max