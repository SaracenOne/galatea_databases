@tool
extends "./generic_record.gd"
		
		
func _load_record(p_dictionary_record, p_database_record):
	# Read Data
	super._load_record(p_dictionary_record, p_database_record)

func _save_record(p_database_record, p_dictionary_record):
	# Write Data
	super._save_record(p_database_record, p_dictionary_record)
