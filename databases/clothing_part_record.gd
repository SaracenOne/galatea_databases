@tool
extends "./generic_record.gd"

@export var male_model_path: String = ""
@export var female_model_path: String = ""

@export var male_model_materials: Array = []
@export var female_model_materials: Array = []

@export var is_attachment: bool = false
@export var bone_attachment_name: String = ""

func _load_record(p_dictionary_record, p_databases):
	# Read Data
	super._load_record(p_dictionary_record, p_databases)
	
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
			
	if(p_dictionary_record.has("is_attachment")):
		is_attachment = p_dictionary_record.is_attachment
		
	if(p_dictionary_record.has("bone_attachment_name")):
		bone_attachment_name = p_dictionary_record.bone_attachment_name

func _save_record(p_dictionary_record, p_databases):
	# Write Data
	super._save_record(p_dictionary_record, p_databases)
	
	p_dictionary_record.male_model_path = male_model_path
	p_dictionary_record.female_model_path = female_model_path
	
	p_dictionary_record.male_model_materials = []
	for male_model_material in male_model_materials:
		p_dictionary_record.male_model_materials.append(male_model_material)
		
	p_dictionary_record.female_model_materials = []
	for female_model_material in female_model_materials:
		p_dictionary_record.female_model_materials.append(female_model_material)
		
	p_dictionary_record.is_attachment = is_attachment
	p_dictionary_record.bone_attachment_name = bone_attachment_name
