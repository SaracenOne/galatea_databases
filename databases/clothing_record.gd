extends "generic_record.gd"

const generic_database_const = preload("generic_database.gd")

enum biped_enum {
	BIPED_HEAD = 1 >> 1,
	BIPED_UPPER_BODY = 1 >> 2,
	BIPED_LOWER_BODY = 1 >> 3,
	BIPED_HANDS = 1 >> 4,
	BIPED_FEET = 1 >> 5,
	# Stamp-based
	BIPED_UPPER_UNDERWEAR = 1 >> 6,
	BIPED_LOWER_UNDERWEAR = 1 >> 7,
	BIPED_SOCKS = 1 >> 8,
}

const biped_name_array = ["Head", "Upper Body", "Lower Body", "Hands", "Feet", "Upper Underwear", "Lower Underwear", "Socks"]

export(String) var printed_name = ""
export(Array) var clothing_parts = []
export(int) var biped_flags = 0

export(Dictionary) var male_stamp_table = {}
export(Dictionary) var female_stamp_table = {}

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
				
	if(p_dictionary_record.has("biped_flags")):
		biped_flags = int(p_dictionary_record.biped_flags)
				
	male_stamp_table = {}
	if(p_dictionary_record.has("male_stamp_table")):
		for key in p_dictionary_record.male_stamp_table.keys():
			male_stamp_table[key] = generic_database_const.convert_string_to_color(p_dictionary_record.male_stamp_table[key])
	
	female_stamp_table = {}
	if(p_dictionary_record.has("female_stamp_table")):
		for key in p_dictionary_record.female_stamp_table.keys():
			female_stamp_table[key] = generic_database_const.convert_string_to_color(p_dictionary_record.female_stamp_table[key])
	
func _save_record(p_dictionary_record, p_databases):
	# Write Data
	._save_record(p_dictionary_record, p_databases)
	
	p_dictionary_record.printed_name = printed_name
	
	p_dictionary_record.clothing_parts = []
	for clothing_part in clothing_parts:
		p_dictionary_record.clothing_parts.append(clothing_part.id)
		
	p_dictionary_record.biped_flags = int(biped_flags)
		
	p_dictionary_record.male_stamp_table = male_stamp_table
	p_dictionary_record.female_stamp_table = female_stamp_table