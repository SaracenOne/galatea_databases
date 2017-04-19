extends "generic_record.gd"

const body_scaler_database_const = preload("body_scaler_database.gd")
		
export(bool) var character_creator = false
export(String) var printed_name = ""
export(int) var default_value = 0
		
class ScalerCommand extends Resource:
	export(int) var command_id = body_scaler_database_const.COMMAND_SCALE
	export(Vector3) var command_value = Vector3(1.0, 1.0, 1.0)
	export(bool) var inverse = false
	export(float) var min_value = 0.0
	export(float) var max_value = 1.0
	
	func load_record(p_dictionary):
		command_id = body_scaler_database_const.get_command_type_from_string(p_dictionary.command_id)
		command_value = body_scaler_database_const.convert_string_to_vector_3(p_dictionary.command_value)
		inverse = p_dictionary.inverse
		min_value = p_dictionary.min_value
		max_value = p_dictionary.max_value
		
	func save_record():
		var dictionary = {}
		dictionary.command_id = body_scaler_database_const.get_string_from_command_type(command_id)
		dictionary.command_value = command_value
		dictionary.inverse = inverse
		dictionary.min_value = min_value
		dictionary.max_value = max_value
		
		return dictionary
		
class ScalerBone extends Resource:
	export(Array) var scaler_commands = []
	
	func load_record(p_dictionary):
		if(p_dictionary.has("scaler_commands")):
			for scale_command_dict in p_dictionary.scaler_commands:
				var scaler_command = ScalerCommand.new()
				scaler_command.load_record(scale_command_dict)
				scaler_commands.append(scaler_command)
				
	func save_record():
		var dictionary = {}
		var scaler_commands_dict_array = []
		for scaler_command in scaler_commands:
			scaler_commands_dict_array.append(scaler_command.save_record())
			
		dictionary.scaler_commands = scaler_commands_dict_array
		
		return dictionary

export(Dictionary) var scaler_bones = {}

func _load_record(p_dictionary_record, p_databases):
	# Read Data
	._load_record(p_dictionary_record, p_databases)
	
	scaler_bones = {}
	
	if(p_dictionary_record.has("character_creator")):
		character_creator = p_dictionary_record.character_creator
		
	if(p_dictionary_record.has("printed_name")):
		printed_name = p_dictionary_record.printed_name
		
	if(p_dictionary_record.has("default_value")):
		default_value = p_dictionary_record.default_value
		
	if(p_dictionary_record.has("scaler_bones")):
		for bone_scaler_key in p_dictionary_record.scaler_bones.keys():
			var bone_scaler_value = p_dictionary_record.scaler_bones[bone_scaler_key]
			var scaler_bone = ScalerBone.new()
			scaler_bone.load_record(bone_scaler_value)
			scaler_bones[bone_scaler_key] = scaler_bone
			
func _save_record(p_dictionary_record, p_databases):
	# Write Data
	._save_record(p_dictionary_record, p_databases)
	
	p_dictionary_record.character_creator = character_creator
	p_dictionary_record.printed_name = printed_name
	p_dictionary_record.default_value = default_value
	
	var scaler_bones_dict_array = {}
	
	for scaler_bone_key in scaler_bones.keys():
		var scaler_bone_value = scaler_bones[scaler_bone_key]
		scaler_bones_dict_array[scaler_bone_key] = scaler_bone_value.save_record()
		
	p_dictionary_record.scaler_bones = scaler_bones_dict_array