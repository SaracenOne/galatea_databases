extends "generic_record.gd"

var printed_name = ""
var invisible = true
var autostart = false

func _load_record(p_dictionary_record, p_databases):
	# Read Data
	._load_record(p_dictionary_record, p_databases)
	
	if(p_dictionary_record.has("printed_name")):
		printed_name = p_dictionary_record.printed_name
		
	if(p_dictionary_record.has("invisible")):
		invisible = p_dictionary_record.invisible
	
func _save_record(p_dictionary_record):
	# Write Data
	._save_record(p_dictionary_record)
	
	p_dictionary_record.printed_name = printed_name
	p_dictionary_record.invisible = invisible