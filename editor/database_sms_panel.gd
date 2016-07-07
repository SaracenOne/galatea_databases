tool
extends "database_panel.gd"

export(NodePath) var actor = NodePath()
export(NodePath) var message_body = NodePath()
export(NodePath) var is_reply = NodePath()

onready var _actor_control = get_node(actor)
onready var _message_body_control = get_node(message_body)
onready var _is_reply_control = get_node(is_reply)

#
var database_records = null

func _ready():
	pass

func galatea_databases_assigned():
	database_records = get_node("LeftSide/DatabaseRecords")
	assert(database_records)
	
	if not(is_connected("new_record_duplicate", database_records, "new_record_duplicate_callback")):
		connect("new_record_duplicate", database_records, "new_record_duplicate_callback")
		
	if not(is_connected("new_record_add_successful", database_records, "new_record_add_successful_callback")):
		connect("new_record_add_successful", database_records, "new_record_add_successful_callback")
		
	if not(is_connected("rename_record_successful", database_records, "rename_record_successful_callback")):
		connect("rename_record_successful", database_records, "rename_record_successful_callback")
		
	if not(is_connected("erase_record_successful", database_records, "erase_record_successful_callback")):
		connect("erase_record_successful", database_records, "erase_record_successful_callback")
	
	current_database = galatea_databases.sms_database
	if(current_database != null):
		database_records.populate_tree(current_database, null)
		_actor_control.assign_database(galatea_databases.actor_database)
	else:
		printerr("sms_database is null")

func set_current_record_callback(p_record):
	.set_current_record_callback(p_record)

	if(p_record.actor):
		_actor_control.set_record_name(p_record.actor.id)
	else:
		_actor_control.set_record_name("")
	_actor_control.set_disabled(false)
	
	_message_body_control.set_text(p_record.message_body)
	
	_is_reply_control.set_disabled(false)
	_is_reply_control.set_pressed(p_record.is_reply)

func _on_ActorRecordsReference_record_selected( p_record ):
	if(current_record):
		current_record.actor = p_record
		current_database.mark_database_as_modified()

func _on_ActorRecordsReference_record_erased( p_record ):
	if(current_record):
		current_record.actor = null
		current_database.mark_database_as_modified()

func _on_MessageBodyTextEdit_draw():
	if(current_record):
		current_record.message_body = _message_body_control.get_text()
		current_database.mark_database_as_modified()

func _on_IsReplyCheckbox_toggled( pressed ):
	if(current_record):
		current_record.is_reply = pressed
		current_database.mark_database_as_modified()