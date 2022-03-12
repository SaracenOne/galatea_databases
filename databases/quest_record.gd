@tool
extends "./generic_record.gd"

@export var printed_name: String = ""
@export var invisible: bool = true
@export var autostart: bool = false

func _load_record(p_dictionary_record, p_databases):
	# Read Data
	super._load_record(p_dictionary_record, p_databases)
	
	if(p_dictionary_record.has("printed_name")):
		printed_name = p_dictionary_record.printed_name
		
	if(p_dictionary_record.has("invisible")):
		invisible = p_dictionary_record.invisible
	
func _save_record(p_dictionary_record, p_databases):
	# Write Data
	super._save_record(p_dictionary_record, p_databases)
	
	p_dictionary_record.printed_name = printed_name
	p_dictionary_record.invisible = invisible
