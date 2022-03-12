@tool
extends "./generic_record.gd"

@export var actor: Resource = null
@export var is_reply: bool = false
@export var message_body: String = ""

func _load_record(p_dictionary_record, p_databases):
	# Read Data
	super._load_record(p_dictionary_record, p_databases)
	
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
	super._save_record(p_dictionary_record, p_databases)
	
	if(actor):
		p_dictionary_record.actor = actor.id
	else:
		p_dictionary_record.actor = ""
	p_dictionary_record.is_reply = is_reply
	p_dictionary_record.message_body = message_body
