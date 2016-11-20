extends "generic_record.gd"

const generic_database_const = preload("generic_database.gd")

var printed_name = ""
var clothing_parts = []

var stamp_table = {}

func _load_record(p_dictionary_record, p_databases):
	# Read Data
	._load_record(p_dictionary_record, p_databases)
	
	if(p_dictionary_record.has("printed_name")):
		printed_name = p_dictionary_record.printed_name
		
	if(p_dictionary_record.has("clothing_parts")):
		for clothing_part in p_dictionary_record.clothing_parts:
			var clothing_part_record = p_databases.clothing_part_database.find_record_by_name(clothing_part)
			if(clothing_part_record != null):
				clothing_parts.append(clothing_part_record)
				
	stamp_table = {}
	if(p_dictionary_record.has("stamp_table")):
		for key in p_dictionary_record.stamp_table.keys():
			stamp_table[key] = generic_database_const.convert_string_to_color(p_dictionary_record.stamp_table[key])
	
func _save_record(p_dictionary_record, p_databases):
	# Write Data
	._save_record(p_dictionary_record, p_databases)
	
	p_dictionary_record.printed_name = printed_name
	
	p_dictionary_record.clothing_parts = []
	for clothing_part in clothing_parts:
		p_dictionary_record.clothing_parts.append(clothing_part.id)
		
	p_dictionary_record.stamp_table = stamp_table