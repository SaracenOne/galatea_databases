# Special script to scrape the associated scene files of the location records and extract useful
# information from
@tool
extends Node

const record_instance_const = preload("../instances/record_instance_node.gd")
const actor_instance_const = preload("../instances/actor_instance_node.gd")
const item_instance_const = preload("../instances/item_instance_node.gd")

static func is_record_instance_script(p_script):
	return p_script == record_instance_const or p_script == actor_instance_const or p_script == item_instance_const

static func decode_packed_scene(p_packed_scene):
	var actor_dictionary = {}
	var item_dictionary = {}
	
	if p_packed_scene is PackedScene and p_packed_scene.can_instantiate():
		var valid_nodes = []
		var scene_state = p_packed_scene.get_state()
		
		for i in range(0, scene_state.get_node_count()):
			var script = null
			var transform = Transform3D()
			var id = ""
			
			for j in range(0, scene_state.get_node_property_count(i)): 
				if(scene_state.get_node_property_name(i, j) == "transform"):
					if typeof(scene_state.get_node_property_value(i, j)) == TYPE_TRANSFORM3D:
						transform = scene_state.get_node_property_value(i, j)
						
				if(scene_state.get_node_property_name(i, j) == "id"):
					if typeof(scene_state.get_node_property_value(i, j)) == TYPE_STRING:
						id = scene_state.get_node_property_value(i, j)
			
				if(scene_state.get_node_property_name(i, j) == "script"):
					if is_record_instance_script(scene_state.get_node_property_value(i, j)):
						script = scene_state.get_node_property_value(i, j)
			
			if script:
				if script == actor_instance_const:
					actor_dictionary[scene_state.get_node_name(i)] = {"transform":transform, "id":id}
				elif script == item_instance_const:
					item_dictionary[scene_state.get_node_name(i)] = {"transform":transform, "id":id}
					
	return {"actors":actor_dictionary, "items":item_dictionary}

static func compile_record_location(p_record):
	var location_dictionary = {"actors":{}, "items":{}}
	if ResourceLoader.has(p_record.scene_path):
		var packed_scene = ResourceLoader.load(p_record.scene_path)
		if packed_scene is PackedScene and packed_scene.can_instantiate():
			location_dictionary = decode_packed_scene(packed_scene)
			
	return location_dictionary
	
static func compile_locations(p_location_database):
	var location_dictionary = {}
	for key in p_location_database.database_records.keys():
		var record = p_location_database.database_records[key]
		location_dictionary[key] = compile_record_location(record)
	return location_dictionary

static func create_directory():
	var compiled_directory = Directory.new()
	if(compiled_directory.dir_exists("res://assets") == false):
			if(compiled_directory.make_dir("res://assets/compiled") != OK):
				printerr("Could not create compiled directory ):")
				return null
	
	if(compiled_directory.open("res://assets") == OK):
		if(compiled_directory.dir_exists("res://assets/compiled") == false):
			if(compiled_directory.make_dir("res://assets/compiled") != OK):
				printerr("Could not create compiled directory ):")
				return null
				
static func save_data_file(p_path, p_dictionary):
	var file = File.new()
	var file_error = file.open(p_path, File.WRITE)
	if(!file_error == OK):
		printerr("compiler: failed to save file (%s) error code: %u", p_path, file_error)
		return file_error
	file.seek(0)
	
	var json = JSON.new()
	var json_string = json.stringify(p_dictionary)
	file.store_string(json_string)
	file.close()
				
static func save_data_files(p_data_dictionary):
	for key in p_data_dictionary.keys():
		var file_path = "res://assets/compiled/" + key + "_data.json"
		save_data_file(file_path, p_data_dictionary[key])
	
	return OK
	
static func load_data_file(p_path):
	var file = File.new()
	if file.file_exists(p_path):
		var file_error = file.open(p_path, File.READ)
		if(!file_error == OK):
			printerr("compiler: failed to load file (%s) error code: %u", p_path, file_error)
			return file_error
		var file_buffer_string = file.get_as_text()
		file.close()
		
		var json = JSON.new()
		var dictionary = json.parse(file_buffer_string)
		if typeof(dictionary) == TYPE_DICTIONARY:
			return dictionary
	
	return null
		

static func compile_location_data(p_galatea_databases):
	create_directory()
	
	var location_dictionary = compile_locations(p_galatea_databases.location_database)
	if(save_data_files(location_dictionary) != OK):
		printerr("data files did not save correctly!")
	
