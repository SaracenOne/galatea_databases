extends "generic_record.gd"
		
var printed_name = ""
var description = ""
var main_icon_path = ""

var visible_in_character_creator = false

var contradictory_traits = []

func _load_record(p_dictionary_record, p_databases):
	# Read Data
	._load_record(p_dictionary_record, p_databases)
	
	if(p_dictionary_record.has("printed_name")):
		printed_name = p_dictionary_record.printed_name
		
	if(p_dictionary_record.has("description")):
		description = p_dictionary_record.description
		
	if(p_dictionary_record.has("main_icon_path")):
		main_icon_path = p_dictionary_record.main_icon_path
		
	if(p_dictionary_record.has("visible_in_character_creator")):
		visible_in_character_creator = p_dictionary_record.visible_in_character_creator
		
	if(p_dictionary_record.has("contradictory_traits")):
		for contradictory_trait_name in p_dictionary_record.contradictory_traits:
			var contradictory_trait = p_databases.trait_database.find_record_by_name(contradictory_trait_name)
			if(contradictory_trait != null):
				contradictory_traits.append(contradictory_trait)
				
func _save_record(p_dictionary_record):
	# Write Data
	._save_record(p_dictionary_record)
	
	p_dictionary_record.printed_name = printed_name
	p_dictionary_record.description = description
	p_dictionary_record.main_icon_path = main_icon_path
	p_dictionary_record.visible_in_character_creator = visible_in_character_creator
	
	p_dictionary_record.contradictory_traits = []
	for contradictory_trait in contradictory_traits:
		p_dictionary_record.contradictory_traits.append(contradictory_trait.id)#