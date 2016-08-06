extends "generic_record.gd"

var texture_path = ""
var shader_path = ""
var sub_texture_count_x = 1
var sub_texture_count_y = 1
var box_size = 5.0
var particle_density = 1.0
var particle_rotation_velocity = 0.0
var particle_size = Vector2(1.0, 1.0)
var wind_multiplier = 0.0

func _load_record(p_dictionary_record, p_databases):
	# Read Data
	._load_record(p_dictionary_record, p_databases)
	
	if(p_dictionary_record.has("texture_path")):
		texture_path = p_dictionary_record.texture_path
		
	if(p_dictionary_record.has("shader_path")):
		shader_path = p_dictionary_record.shader_path
		
	if(p_dictionary_record.has("sub_texture_count_x")):
		sub_texture_count_x = p_dictionary_record.sub_texture_count_x
		
	if(p_dictionary_record.has("sub_texture_count_y")):
		sub_texture_count_y = p_dictionary_record.sub_texture_count_y
		
	if(p_dictionary_record.has("box_size")):
		box_size = p_dictionary_record.box_size
	
	if(p_dictionary_record.has("particle_density")):
		particle_density = p_dictionary_record.particle_density
		
	if(p_dictionary_record.has("particle_rotation_velocity")):
		particle_rotation_velocity = p_dictionary_record.particle_rotation_velocity
		
	if(p_dictionary_record.has("particle_size")):
		particle_size = p_dictionary_record.particle_size
		
	if(p_dictionary_record.has("wind_multiplier")):
		wind_multiplier = p_dictionary_record.wind_multiplier
	
func _save_record(p_dictionary_record):
	# Write Data
	._save_record(p_dictionary_record)
	
	p_dictionary_record.texture_path = texture_path
	p_dictionary_record.shader_path = shader_path
	p_dictionary_record.sub_texture_count_x = sub_texture_count_x
	p_dictionary_record.sub_texture_count_y = sub_texture_count_y
	p_dictionary_record.box_size = box_size
	p_dictionary_record.particle_density = particle_density
	p_dictionary_record.particle_rotation_velocity = particle_rotation_velocity
	p_dictionary_record.particle_size = particle_size
	p_dictionary_record.wind_multiplier = wind_multiplier