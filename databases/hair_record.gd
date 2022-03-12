@tool
extends "./generic_record.gd"

@export var printed_name: String = ""
@export var scene_path: String = ""
@export var physics_path: String = ""
@export var main_icon_path: String = ""
@export var character_creator: bool = false
@export var male: bool = false
@export var female: bool = false

func _load_record(p_dictionary_record, p_databases):
	# Read Data
	super._load_record(p_dictionary_record, p_databases)
	
	if(p_dictionary_record.has("printed_name")):
		printed_name = p_dictionary_record.printed_name
		
	if(p_dictionary_record.has("scene_path")):
		scene_path = p_dictionary_record.scene_path
		
	if(p_dictionary_record.has("physics_path")):
		physics_path = p_dictionary_record.physics_path
		
	if(p_dictionary_record.has("main_icon_path")):
		main_icon_path = p_dictionary_record.main_icon_path
		
	if(p_dictionary_record.has("character_creator")):
		character_creator = p_dictionary_record.character_creator
		
	if(p_dictionary_record.has("male")):
		male = p_dictionary_record.male
		
	if(p_dictionary_record.has("female")):
		female = p_dictionary_record.female
	
func _save_record(p_dictionary_record, p_databases):
	# Write Data
	super._save_record(p_dictionary_record, p_databases)
	
	p_dictionary_record.printed_name = printed_name
	p_dictionary_record.scene_path = scene_path
	p_dictionary_record.physics_path = physics_path
	p_dictionary_record.main_icon_path = main_icon_path
	p_dictionary_record.character_creator = character_creator
	p_dictionary_record.male = male
	p_dictionary_record.female = female
