extends "generic_record.gd"

const generic_database_const = preload("generic_database.gd")

export(String) var texture_path = ""
export(String) var shader_path = ""
export(int) var sub_texture_count_xy = 1
export(float) var box_size = 5.0
export(float) var particle_density = 1.0
export(float) var particle_rotation_velocity = 0.0
export(Vector2) var particle_size = Vector2(1.0, 1.0)
export(float) var wind_multiplier = 0.0

func _load_record(p_dictionary_record, p_databases):
	# Read Data
	._load_record(p_dictionary_record, p_databases)
	
	if(p_dictionary_record.has("texture_path")):
		texture_path = p_dictionary_record.texture_path
		
	if(p_dictionary_record.has("shader_path")):
		shader_path = p_dictionary_record.shader_path
		
	if(p_dictionary_record.has("sub_texture_count_xy")):
		sub_texture_count_xy = p_dictionary_record.sub_texture_count_xy
		
	if(p_dictionary_record.has("box_size")):
		box_size = p_dictionary_record.box_size
	
	if(p_dictionary_record.has("particle_density")):
		particle_density = p_dictionary_record.particle_density
		
	if(p_dictionary_record.has("particle_rotation_velocity")):
		particle_rotation_velocity = p_dictionary_record.particle_rotation_velocity
		
	if(p_dictionary_record.has("particle_size")):
		particle_size = generic_database_const.convert_string_to_vector_2(p_dictionary_record.particle_size)
		
	if(p_dictionary_record.has("wind_multiplier")):
		wind_multiplier = p_dictionary_record.wind_multiplier
	
func _save_record(p_dictionary_record, p_databases):
	# Write Data
	._save_record(p_dictionary_record, p_databases)
	
	p_dictionary_record.texture_path = texture_path
	p_dictionary_record.shader_path = shader_path
	p_dictionary_record.sub_texture_count_xy = sub_texture_count_xy
	p_dictionary_record.box_size = box_size
	p_dictionary_record.particle_density = particle_density
	p_dictionary_record.particle_rotation_velocity = particle_rotation_velocity
	p_dictionary_record.particle_size = particle_size
	p_dictionary_record.wind_multiplier = wind_multiplier