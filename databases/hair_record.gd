extends "generic_record.gd"

export(String) var printed_name = ""
export(String) var scene_path = ""
export(String) var main_icon_path = ""

func _load_record(p_dictionary_record, p_databases):
	# Read Data
	._load_record(p_dictionary_record, p_databases)
	
	if(p_dictionary_record.has("printed_name")):
		printed_name = p_dictionary_record.printed_name
		
	if(p_dictionary_record.has("scene_path")):
		scene_path = p_dictionary_record.scene_path
		
	if(p_dictionary_record.has("main_icon_path")):
		main_icon_path = p_dictionary_record.main_icon_path
	
func _save_record(p_dictionary_record, p_databases):
	# Write Data
	._save_record(p_dictionary_record, p_databases)
	
	p_dictionary_record.printed_name = printed_name
	p_dictionary_record.scene_path = scene_path
	p_dictionary_record.main_icon_path = main_icon_path