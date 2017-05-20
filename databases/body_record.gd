extends "generic_record.gd"

const date_and_time_const = preload("res://addons/date_and_time/date_and_time.gd")
const generic_database_const = preload("generic_database.gd")

export(String) var skeleton_male_path = ""
export(String) var skeleton_female_path = ""

export(String) var physics_male_path = ""
export(String) var physics_female_path = ""

export(Resource) var naked_clothing_set = null

export(Resource) var male_skin_stamp = null
export(Resource) var female_skin_stamp = null

export(Array) var body_scaler_male_table = []
export(Array) var body_scaler_female_table = []

func _load_record(p_dictionary_record, p_databases):
	# Read Data
	._load_record(p_dictionary_record, p_databases)
	
	if(p_dictionary_record.has("skeleton_male_path")):
		skeleton_male_path = p_dictionary_record.skeleton_male_path
	if(p_dictionary_record.has("skeleton_female_path")):
		skeleton_female_path = p_dictionary_record.skeleton_female_path
		
	if(p_dictionary_record.has("physics_male_path")):
		physics_male_path = p_dictionary_record.physics_male_path
	if(p_dictionary_record.has("physics_female_path")):
		physics_female_path = p_dictionary_record.physics_female_path
	
	if(p_dictionary_record.has("naked_clothing_set")):
		naked_clothing_set = p_databases.clothing_set_database.find_record_by_name(p_dictionary_record.naked_clothing_set)
	else:
		naked_clothing_set = null
		
	if(p_dictionary_record.has("male_skin_stamp")):
		male_skin_stamp = p_databases.stamp_database.find_record_by_name(p_dictionary_record.male_skin_stamp)
	else:
		male_skin_stamp = null
		
	if(p_dictionary_record.has("female_skin_stamp")):
		female_skin_stamp = p_databases.stamp_database.find_record_by_name(p_dictionary_record.female_skin_stamp)
	else:
		female_skin_stamp = null
		
	body_scaler_male_table = []
	if(p_dictionary_record.has("body_scaler_male_table")):
		for id in p_dictionary_record.body_scaler_male_table:
			var body_scaler = p_databases.body_scaler_database.find_record_by_name(id)
			if body_scaler:
				body_scaler_male_table.append(body_scaler)
		
	body_scaler_female_table = []
	if(p_dictionary_record.has("body_scaler_female_table")):
		for id in p_dictionary_record.body_scaler_female_table:
			var body_scaler = p_databases.body_scaler_database.find_record_by_name(id)
			if body_scaler:
				body_scaler_female_table.append(body_scaler)
		
func _save_record(p_dictionary_record, p_databases):
	# Write Data
	._save_record(p_dictionary_record, p_databases)
	
	if(skeleton_male_path):
		p_dictionary_record.skeleton_male_path = skeleton_male_path
	else:
		p_dictionary_record.skeleton_male_path = ""
		
	if(skeleton_female_path):
		p_dictionary_record.skeleton_female_path = skeleton_female_path
	else:
		p_dictionary_record.skeleton_female_path = ""
		
	if(physics_male_path):
		p_dictionary_record.physics_male_path = physics_male_path
	else:
		p_dictionary_record.physics_male_path = ""
		
	if(physics_female_path):
		p_dictionary_record.physics_female_path = physics_female_path
	else:
		p_dictionary_record.physics_female_path = ""
	
	if(naked_clothing_set):
		p_dictionary_record.naked_clothing_set = naked_clothing_set.id
	else:
		p_dictionary_record.naked_clothing_set = ""
		
	if(male_skin_stamp):
		p_dictionary_record.male_skin_stamp = male_skin_stamp.id
	else:
		p_dictionary_record.male_skin_stamp = ""
		
	if(female_skin_stamp):
		p_dictionary_record.female_skin_stamp = female_skin_stamp.id
	else:
		p_dictionary_record.female_skin_stamp = ""
		
	p_dictionary_record.body_scaler_male_table = []
	for record in body_scaler_male_table:
		p_dictionary_record.body_scaler_male_table.append(record.id)
		
	p_dictionary_record.body_scaler_female_table = []
	for record in body_scaler_female_table:
		p_dictionary_record.body_scaler_female_table.append(record.id)