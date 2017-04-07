extends "generic_record.gd"

export(String) var male_model_path = ""
export(String) var female_model_path = ""

export(Array) var male_model_materials = []
export(Array) var female_model_materials = []

func _load_record(p_dictionary_record, p_databases):
	# Read Data
	._load_record(p_dictionary_record, p_databases)
	
	if(p_dictionary_record.has("male_model_path")):
		male_model_path = p_dictionary_record.male_model_path
		
	if(p_dictionary_record.has("female_model_path")):
		female_model_path = p_dictionary_record.female_model_path
		
	if(p_dictionary_record.has("male_model_materials")):
		for male_model_material in p_dictionary_record.male_model_materials:
			male_model_materials.append(male_model_material)
			
	if(p_dictionary_record.has("female_model_materials")):
		for female_model_material in p_dictionary_record.female_model_materials:
			female_model_materials.append(female_model_material)

func _save_record(p_dictionary_record, p_databases):
	# Write Data
	._save_record(p_dictionary_record, p_databases)
	
	p_dictionary_record.male_model_path = male_model_path
	p_dictionary_record.female_model_path = female_model_path
	
	p_dictionary_record.male_model_materials = []
	for male_model_material in male_model_materials:
		p_dictionary_record.male_model_materials.append(male_model_material)
		
	p_dictionary_record.female_model_materials = []
	for female_model_material in female_model_materials:
		p_dictionary_record.female_model_materials.append(female_model_material)