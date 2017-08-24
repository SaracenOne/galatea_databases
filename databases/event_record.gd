extends "generic_record.gd"

const conditionals_const = preload("../conditionals/conditionals.gd")

export(String) var adv_label = ""
export(int) var priority = 0
export(bool) var manual = false
export(Resource) var conditionals = conditionals_const.new()

func _load_record(p_dictionary_record, p_databases):
	# Read Data
	._load_record(p_dictionary_record, p_databases)

	if(p_dictionary_record.has("adv_label")):
		adv_label = p_dictionary_record.adv_label
	if(p_dictionary_record.has("priority")):
		priority = p_dictionary_record.priority
	if(p_dictionary_record.has("manual")):
		manual = p_dictionary_record.manual
	if(p_dictionary_record.has("conditionals")):
		conditionals_const.load_from_dictionary(conditionals, p_dictionary_record.conditionals, p_databases)

func _save_record(p_dictionary_record, p_databases):
	# Write Data
	._save_record(p_dictionary_record, p_databases)

	p_dictionary_record.adv_label = adv_label
	p_dictionary_record.priority = priority
	p_dictionary_record.manual = manual
	p_dictionary_record.conditionals = conditionals_const.save_to_dictionary(conditionals, p_databases)