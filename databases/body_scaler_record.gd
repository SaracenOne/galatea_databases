extends "generic_record.gd"

class BoneScaler extends Reference:
	var bone_name=""
	var inverse=false
	var scale=Vector3()
	
	func parse_bone_scaler():
		pass
	
var body_scaler_name = ""
var body_scaler_printed_name = ""

var is_hidden=false

var bone_scalers = []

func parse_body_scaler():
	pass
	
func _load_record(p_dictionary_record, p_databases):
	# Read Data
	._load_record(p_dictionary_record, p_databases)
	
func _save_record(p_dictionary_record):
	# Write Data
	._save_record(p_dictionary_record)