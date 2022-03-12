@tool
extends "./generic_record.gd"

const conversion_const = preload("../data/conversion.gd")

@export var texture_path: String = ""
@export var shader_path: String = ""
@export var sub_texture_count_xy: int = 1
@export var box_size: float = 5.0
@export var particle_density: float = 1.0
@export var particle_rotation_velocity: float = 0.0
@export var particle_size: Vector2 = Vector2(1.0, 1.0)
@export var wind_multiplier: float = 0.0

func _load_record(p_dictionary_record, p_databases):
	# Read Data
	super._load_record(p_dictionary_record, p_databases)
	
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
		particle_size = conversion_const.convert_string_to_vector_2(p_dictionary_record.particle_size)
		
	if(p_dictionary_record.has("wind_multiplier")):
		wind_multiplier = p_dictionary_record.wind_multiplier
	
func _save_record(p_dictionary_record, p_databases):
	# Write Data
	super._save_record(p_dictionary_record, p_databases)
	
	p_dictionary_record.texture_path = texture_path
	p_dictionary_record.shader_path = shader_path
	p_dictionary_record.sub_texture_count_xy = sub_texture_count_xy
	p_dictionary_record.box_size = box_size
	p_dictionary_record.particle_density = particle_density
	p_dictionary_record.particle_rotation_velocity = particle_rotation_velocity
	p_dictionary_record.particle_size = particle_size
	p_dictionary_record.wind_multiplier = wind_multiplier
