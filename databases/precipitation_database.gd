const generic_database_const = preload("generic_database.gd")

class PrecipitationDatabase:
	extends "generic_database.gd".GenericDatabase
	
	const DATABASE_IDENT = "PRCP"
	const DATABASE_NAME = "precipitation_database"
	const DATABASE_NAME_JSON = "precipitation_database.json"
	const DATABASE_NAME_BINARY = "precipitation_database.gdb"
	const DATABASE_INLINED_FILENAME = "precipitation_database_inlined.gd"
	const RECORDS_NAME = "precipitation_database_records"

	class PrecipitationRecord:
		extends "generic_database.gd".GenericRecord
		
		var texture_path = ""
		var shader_path = ""
		var sub_texture_count_x = 1
		var sub_texture_count_y = 1
		var box_size = 5.0
		var particle_density = 1.0
		var particle_rotation_velocity = 0.0
		var particle_size = Vector2(1.0, 1.0)
		var wind_multiplier = 0.0
		
	func get_database_name():
		return DATABASE_NAME
		
	func get_inlined_filename():
		return DATABASE_INLINED_FILENAME
		
	func load_database_ids():
		return _load_database_ids(databases.path + "/" + DATABASE_NAME_JSON, RECORDS_NAME)
		
	func _load_record(p_dictionary_record, p_database_record):
		# Read Data
		._load_record(p_dictionary_record, p_database_record)
		
		if(p_dictionary_record.has("texture_path")):
			p_database_record.texture_path = p_dictionary_record.texture_path
			
		if(p_dictionary_record.has("shader_path")):
			p_database_record.shader_path = p_dictionary_record.shader_path
			
		if(p_dictionary_record.has("sub_texture_count_x")):
			p_database_record.sub_texture_count_x = p_dictionary_record.sub_texture_count_x
			
		if(p_dictionary_record.has("sub_texture_count_y")):
			p_database_record.sub_texture_count_y = p_dictionary_record.sub_texture_count_y
			
		if(p_dictionary_record.has("box_size")):
			p_database_record.box_size = p_dictionary_record.box_size
		
		if(p_dictionary_record.has("particle_density")):
			p_database_record.particle_density = p_dictionary_record.particle_density
			
		if(p_dictionary_record.has("particle_rotation_velocity")):
			p_database_record.particle_rotation_velocity = p_dictionary_record.particle_rotation_velocity
			
		if(p_dictionary_record.has("particle_size")):
			p_database_record.particle_size = p_dictionary_record.particle_size
			
		if(p_dictionary_record.has("wind_multiplier")):
			p_database_record.wind_multiplier = p_dictionary_record.wind_multiplier
		
	func load_database_values():
		_load_database_values(databases.path + "/" + DATABASE_NAME_JSON, RECORDS_NAME)
		
	func _save_record(p_database_record, p_dictionary_record):
		# Write Data
		._save_record(p_database_record, p_dictionary_record)
		
		p_dictionary_record.texture_path = p_database_record.texture_path
		p_dictionary_record.shader_path = p_database_record.shader_path
		p_dictionary_record.sub_texture_count_x = p_database_record.sub_texture_count_x
		p_dictionary_record.sub_texture_count_y = p_database_record.sub_texture_count_y
		p_dictionary_record.box_size = p_database_record.box_size
		p_dictionary_record.particle_density = p_database_record.particle_density
		p_dictionary_record.particle_rotation_velocity = p_database_record.particle_rotation_velocity
		p_dictionary_record.particle_size = p_database_record.particle_size
		p_dictionary_record.wind_multiplier = p_database_record.wind_multiplier
		
	func save_database():
		_save_database(databases.path + "/" + DATABASE_NAME_JSON, RECORDS_NAME)
			
	func _create_record():
		return PrecipitationRecord.new()
		
	func _init(p_databases).(p_databases):
		pass