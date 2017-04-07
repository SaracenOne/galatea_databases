extends "generic_record.gd"

export(Resource) var actor = null
export(bool) var is_reply = false
export(String) var message_body = ""

func _load_record(p_dictionary_record, p_databases):
	# Read Data
	._load_record(p_dictionary_record, p_databases)
	
	if(p_dictionary_record.has("actor")):
		var new_actor = p_databases.actor_database.find_record_by_name(p_dictionary_record.actor)
		if(new_actor != null):
			actor = new_actor
			
	if(p_dictionary_record.has("is_reply")):
		is_reply = p_dictionary_record.is_reply
	if(p_dictionary_record.has("message_body")):
		message_body = p_dictionary_record.message_body
		
func _save_record(p_dictionary_record, p_databases):
	# Write Data
	._save_record(p_dictionary_record, p_databases)
	if(actor):
		p_dictionary_record.actor = actor.id
	else:
		p_dictionary_record.actor = ""
	p_dictionary_record.is_reply = is_reply
	p_dictionary_record.message_body = message_body