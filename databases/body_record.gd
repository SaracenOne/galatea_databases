extends "generic_record.gd"

const date_and_time_const = preload("res://addons/date_and_time/date_and_time.gd")
const generic_database_const = preload("generic_database.gd")

var skeleton_male_path = ""
var skeleton_female_path = ""

var head = null
var eyes = null
var eyebrows = null
var mouth = null
var eyelashes = null

var naked_clothing = null

var male_skin_texture_set = null
var female_skin_texture_set = null

var body_scaler_table = {}

func _load_record(p_dictionary_record, p_databases):
	# Read Data
	._load_record(p_dictionary_record, p_databases)
	
	if(p_dictionary_record.has("skeleton_male_path")):
		skeleton_male_path = p_dictionary_record.skeleton_male_path
	if(p_dictionary_record.has("skeleton_female_path")):
		skeleton_female_path = p_dictionary_record.skeleton_female_path
	
	if(p_dictionary_record.has("head")):
		head = p_databases.headpart_database.find_record_by_name(p_dictionary_record.head)
	else:
		head = null		
	if(p_dictionary_record.has("eyes")):
		eyes = p_databases.headpart_database.find_record_by_name(p_dictionary_record.eyes)
	else:
		eyes = null
		
	if(p_dictionary_record.has("eyebrows")):
		eyebrows = p_databases.headpart_database.find_record_by_name(p_dictionary_record.eyebrows)
	else:
		eyebrows = null
		
	if(p_dictionary_record.has("mouth")):
		mouth = p_databases.headpart_database.find_record_by_name(p_dictionary_record.mouth)
	else:
		mouth = null
		
	if(p_dictionary_record.has("eyelashes")):
		eyelashes = p_databases.headpart_database.find_record_by_name(p_dictionary_record.eyelashes)
	else:
		eyelashes = null
		
		
	if(p_dictionary_record.has("naked_clothing")):
		naked_clothing = p_databases.clothing_database.find_record_by_name(p_dictionary_record.naked_clothing)
	else:
		naked_clothing = null
		
	if(p_dictionary_record.has("male_skin_texture_set")):
		male_skin_texture_set = p_databases.texture_set_database.find_record_by_name(p_dictionary_record.male_skin_texture_set)
	else:
		male_skin_texture_set = null
		
	if(p_dictionary_record.has("female_skin_texture_set")):
		female_skin_texture_set = p_databases.texture_set_database.find_record_by_name(p_dictionary_record.female_skin_texture_set)
	else:
		female_skin_texture_set = null
		
	if(p_dictionary_record.has("body_scaler_table")):
		body_scaler_table = p_dictionary_record.body_scaler_table
		
func _save_record(p_dictionary_record, p_databases):
	# Write Data
	._save_record(p_dictionary_record, p_databases)
	
	p_dictionary_record.skeleton_male_path = skeleton_male_path
	p_dictionary_record.skeleton_female_path = skeleton_female_path
	
	if(head):
		p_dictionary_record.head = head.id
	else:
		p_dictionary_record.head = ""
		
	if(eyes):
		p_dictionary_record.eyes = eyes.id
	else:
		p_dictionary_record.eyes = ""
		
	if(eyebrows):
		p_dictionary_record.eyebrows = eyebrows.id
	else:
		p_dictionary_record.eyebrows = ""
		
	if(mouth):
		p_dictionary_record.mouth = mouth.id
	else:
		p_dictionary_record.mouth = ""
		
	if(eyelashes):
		p_dictionary_record.eyelashes = eyelashes.id
	else:
		p_dictionary_record.eyelashes = ""
		
	if(naked_clothing):
		p_dictionary_record.naked_clothing = naked_clothing.id
	else:
		p_dictionary_record.naked_clothing = ""
		
	if(male_skin_texture_set):
		p_dictionary_record.male_skin_texture_set = male_skin_texture_set.id
	else:
		p_dictionary_record.male_skin_texture_set = ""
	if(female_skin_texture_set):
		p_dictionary_record.female_skin_texture_set = female_skin_texture_set.id
	else:
		p_dictionary_record.female_skin_texture_set = ""
		
	p_dictionary_record.body_scaler_table = body_scaler_table