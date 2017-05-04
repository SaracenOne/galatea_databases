extends "generic_record.gd"

export(String) var printed_name = ""
export(Array) var clothes = []

func _load_record(p_dictionary_record, p_databases):
	# Read Data
	._load_record(p_dictionary_record, p_databases)
	
	if(p_dictionary_record.has("printed_name")):
		printed_name = p_dictionary_record.printed_name
	
	if(p_dictionary_record.has("clothes")):
		for clothing_name in p_dictionary_record.clothes:
			var clothing_instance = p_databases.clothing_database.find_record_by_name(clothing_name)
			if(clothing_instance != null):
				clothes.append(clothing_instance)
	
func _save_record(p_dictionary_record, p_databases):
	# Write Data
	._save_record(p_dictionary_record, p_databases)
	
	p_dictionary_record.printed_name = printed_name
	
	p_dictionary_record.clothes = []
	for clothing_instance in clothes:
		p_dictionary_record.clothes.append(clothing_instance.id)