@tool
extends "./generic_record.gd"

@export var printed_name: String = ""
@export var description: String = ""
@export var main_icon_path: String = ""

@export var activity_script_path: String = ""
@export var valid_locations: Array = []

@export var selectable: bool = false

func _load_record(p_dictionary_record, p_databases):
	# Read Data
	super._load_record(p_dictionary_record, p_databases)
	
	if(p_dictionary_record.has("printed_name")):
		printed_name = p_dictionary_record.printed_name
		
	if(p_dictionary_record.has("description")):
		description = p_dictionary_record.description
		
	if(p_dictionary_record.has("main_icon_path")):
		main_icon_path = p_dictionary_record.main_icon_path
		
	if(p_dictionary_record.has("activity_script_path")):
		activity_script_path = p_dictionary_record.activity_script_path
		
	if(p_dictionary_record.has("valid_locations")):
		for valid_location in p_dictionary_record.valid_locations:
			var location = p_databases.location_database.find_record_by_name(valid_location)
			if(location != null):
				valid_locations.append(location)
				
	if(p_dictionary_record.has("selectable")):
		selectable = p_dictionary_record.selectable
		
func _save_record(p_dictionary_record, p_databases):
	# Write Data
	super._save_record(p_dictionary_record, p_databases)
	
	p_dictionary_record.printed_name = printed_name
	p_dictionary_record.description = description
	p_dictionary_record.main_icon_path = main_icon_path
	
	p_dictionary_record.activity_script_path = activity_script_path
	
	p_dictionary_record.valid_locations = []
	for valid_location in valid_locations:
		p_dictionary_record.valid_locations.append(valid_location.id)
		
	p_dictionary_record.selectable = selectable
