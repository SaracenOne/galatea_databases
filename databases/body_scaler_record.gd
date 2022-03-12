@tool
extends "./generic_record.gd"

const body_scaler_const = preload("../data/body_scaler.gd")
		
@export var character_creator: bool = false
@export var printed_name: String = ""
@export var default_value: float = 0.0
		
@export var scaler_bones: Dictionary = {}

func _load_record(p_dictionary_record, p_databases):
	# Read Data
	super._load_record(p_dictionary_record, p_databases)
	
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
			var scaler_bone = body_scaler_const.ScalerBone.new()
			scaler_bone.load_record(bone_scaler_value)
			scaler_bones[bone_scaler_key] = scaler_bone
			
func _save_record(p_dictionary_record, p_databases):
	# Write Data
	super._save_record(p_dictionary_record, p_databases)
	
	p_dictionary_record.character_creator = character_creator
	p_dictionary_record.printed_name = printed_name
	p_dictionary_record.default_value = default_value
	
	var scaler_bones_dict_array = {}
	
	for scaler_bone_key in scaler_bones.keys():
		var scaler_bone_value = scaler_bones[scaler_bone_key]
		scaler_bones_dict_array[scaler_bone_key] = scaler_bone_value.save_record()
		
	p_dictionary_record.scaler_bones = scaler_bones_dict_array
