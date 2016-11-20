extends "generic_record.gd"

var printed_name = ""
var clothing = []

func _load_record(p_dictionary_record, p_databases):
	# Read Data
	._load_record(p_dictionary_record, p_databases)
	
	if(p_dictionary_record.has("printed_name")):
		printed_name = p_dictionary_record.printed_name
	
	if(p_dictionary_record.has("clothing")):
		for clothing_name in p_dictionary_record.clothing:
			var clothing_instance = p_databases.clothing_database.find_record_by_name(clothing_name)
			if(clothing_instance != null):
				clothing.append(clothing_instance)
	
func _save_record(p_dictionary_record, p_databases):
	# Write Data
	._save_record(p_dictionary_record, p_databases)
	
	p_dictionary_record.printed_name = printed_name
	
	p_dictionary_record.clothing = []
	for clothing_instance in clothing:
		p_dictionary_record.clothing.append(clothing_instance.id)