extends "generic_record.gd"

export(String) var printed_name = ""
export(String) var scene_path = ""
export(String) var physics_path = ""
export(String) var main_icon_path = ""
export(bool) var character_creator = false
export(bool) var male = false
export(bool) var female = false

func _load_record(p_dictionary_record, p_databases):
	# Read Data
	._load_record(p_dictionary_record, p_databases)
	
	if(p_dictionary_record.has("printed_name")):
		printed_name = p_dictionary_record.printed_name
		
	if(p_dictionary_record.has("scene_path")):
		scene_path = p_dictionary_record.scene_path
		
	if(p_dictionary_record.has("physics_path")):
		physics_path = p_dictionary_record.physics_path
		
	if(p_dictionary_record.has("main_icon_path")):
		main_icon_path = p_dictionary_record.main_icon_path
		
	if(p_dictionary_record.has("character_creator")):
		character_creator = p_dictionary_record.character_creator
		
	if(p_dictionary_record.has("male")):
		male = p_dictionary_record.male
		
	if(p_dictionary_record.has("female")):
		female = p_dictionary_record.female
	
func _save_record(p_dictionary_record, p_databases):
	# Write Data
	._save_record(p_dictionary_record, p_databases)
	
	p_dictionary_record.printed_name = printed_name
	p_dictionary_record.scene_path = scene_path
	p_dictionary_record.physics_path = physics_path
	p_dictionary_record.main_icon_path = main_icon_path
	p_dictionary_record.character_creator = character_creator
	p_dictionary_record.male = male
	p_dictionary_record.female = female