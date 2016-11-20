extends "generic_record.gd"

var textures = {"diffuse":"", "normal":""}

func _load_record(p_dictionary_record, p_databases):
	# Read Data
	._load_record(p_dictionary_record, p_databases)
	
	textures = {"diffuse":"", "normal":""}
	if(p_dictionary_record.has("textures")):
		for key in p_dictionary_record.textures:
			textures[key] = p_dictionary_record.textures[key]
		
func _save_record(p_dictionary_record, p_databases):
	# Write Data
	._save_record(p_dictionary_record, p_databases)
	
	p_dictionary_record.textures = textures