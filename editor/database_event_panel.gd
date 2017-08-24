tool
extends "database_panel.gd"

export(NodePath) var adv_label = NodePath()
export(NodePath) var priority = NodePath()
export(NodePath) var manual = NodePath()
export(NodePath) var conditionals = NodePath()

onready var _adv_label_control = get_node(adv_label)
onready var _priority_control = get_node(priority)
onready var _manual_control = get_node(manual)
onready var _conditionals_control = get_node(conditionals)

func _ready():
	pass

func galatea_databases_assigned():
	.galatea_databases_assigned()

	current_database = galatea_databases.event_database
	
	_conditionals_control.assign_databases(galatea_databases)

	if(current_database != null):
		database_records.populate_tree(current_database, null)
	else:
		printerr("event_databases is null")

func set_current_record_callback(p_record):
	.set_current_record_callback(p_record)

	_adv_label_control.set_text(current_record.adv_label)
	_adv_label_control.set_editable(true)
	
	_priority_control.set_value(current_record.priority)
	_priority_control.set_editable(true)
	
	_manual_control.set_disabled(false)
	_manual_control.set_pressed(current_record.manual)

	_conditionals_control.assign_conditionals(current_record.conditionals)
	_conditionals_control.set_disabled(false)
		
func _on_DatabaseConditionalList_conditionals_changed(p_conditionals):
	if(current_record):
		current_record.conditionals = p_conditionals
		current_database.mark_database_as_modified()

func _on_ADVLabelLineEdit_text_changed( text ):
	if(current_record):
		current_record.adv_label = text
		current_database.mark_database_as_modified()

func _on_PrioritySpinbox_value_changed( value ):
	if(current_record):
		current_record.priority = value
		current_database.mark_database_as_modified()

func _on_ManualCheckBox_toggled( pressed ):
	if(current_record):
		current_record.manual = pressed
		current_database.mark_database_as_modified()
