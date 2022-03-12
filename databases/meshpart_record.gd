@tool
extends "./generic_record.gd"

const conversion_const = preload("../data/conversion.gd")

@export var mesh_path: String = ""
@export var gen_morph_path: String = ""

@export var target_min: Vector2 = Vector2(0.0, 0.0)
@export var target_max: Vector2 = Vector2(1.0, 1.0)

func _load_record(p_dictionary_record, p_databases):
	# Read Data
	super._load_record(p_dictionary_record, p_databases)

	if(p_dictionary_record.has("mesh_path")):
		mesh_path = p_dictionary_record.mesh_path

	if(p_dictionary_record.has("gen_morph_path")):
		gen_morph_path = p_dictionary_record.gen_morph_path

	if(p_dictionary_record.has("target_min")):
		target_min = conversion_const.convert_string_to_vector_2(p_dictionary_record.target_min)

	if(p_dictionary_record.has("target_max")):
		target_max = conversion_const.convert_string_to_vector_2(p_dictionary_record.target_max)

func _save_record(p_dictionary_record, p_databases):
	# Write Data
	super._save_record(p_dictionary_record, p_databases)

	p_dictionary_record.mesh_path = mesh_path
	p_dictionary_record.gen_morph_path = gen_morph_path

	p_dictionary_record.target_min = target_min
	p_dictionary_record.target_max = target_max
