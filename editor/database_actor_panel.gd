tool
extends "database_panel.gd"

export(NodePath) var family_name = NodePath()
export(NodePath) var given_name = NodePath()
export(NodePath) var nickname = NodePath()
export(NodePath) var gender = NodePath()
export(NodePath) var date_of_birth_day = NodePath()
export(NodePath) var date_of_birth_month = NodePath()
export(NodePath) var age = NodePath()
export(NodePath) var blood_type = NodePath()
export(NodePath) var actor_groups = NodePath()
export(NodePath) var traits = NodePath()

var _family_name_control = null
var _given_name_control = null
var _nickname_control = null
var _gender_control = null

var _date_of_birth_day_control = null
var _date_of_birth_month_control = null

var _age_control = null
var _blood_type_control = null

var _actor_groups_control = null
var _traits_control = null

#
var database_records = null

func _ready():
	_family_name_control = get_node(family_name)
	assert(_family_name_control)
	
	_given_name_control = get_node(given_name)
	assert(_given_name_control)
	
	_nickname_control = get_node(nickname)
	assert(_nickname_control)
	
	_gender_control = get_node(gender)
	assert(_gender_control)
	
	_date_of_birth_day_control = get_node(date_of_birth_day)
	assert(_date_of_birth_day_control)
	
	_date_of_birth_month_control = get_node(date_of_birth_month)
	assert(_date_of_birth_month_control)
	
	_age_control = get_node(age)
	assert(_age_control)
	
	_blood_type_control = get_node(blood_type)
	assert(_blood_type_control)
	
	_actor_groups_control = get_node(actor_groups)
	assert(_actor_groups_control)
	
	_traits_control = get_node(traits)
	assert(_traits_control)
	
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
	
	current_database = galatea_databases.actor_database
	
	if(current_database != null):
		database_records.populate_tree(current_database, null)
		_actor_groups_control.assign_database(galatea_databases.actor_group_database)
		_traits_control.assign_database(galatea_databases.trait_database)
	else:
		printerr("actor_databases is null")

func set_current_record_callback(p_record):
	.set_current_record_callback(p_record)
	
	_family_name_control.set_text(current_record.family_name)
	_family_name_control.set_editable(true)
	
	_given_name_control.set_text(current_record.given_name)
	_given_name_control.set_editable(true)
	
	_nickname_control.set_text(current_record.nickname)
	_nickname_control.set_editable(true)
	
	_gender_control.select(current_record.gender)
	_gender_control.set_disabled(false)
	
	_date_of_birth_day_control.set_value(p_record.date_of_birth_day)
	_date_of_birth_day_control.set_editable(true)
	
	_date_of_birth_month_control.select(p_record.date_of_birth_month - 1)
	_date_of_birth_month_control.set_disabled(false)
	
	_age_control.set_value(p_record.age)
	_age_control.set_editable(true)
	
	_blood_type_control.select(p_record.bloodtype)
	_blood_type_control.set_disabled(false)
	
	_actor_groups_control.set_disabled(false)
	_actor_groups_control.populate_tree(p_record.actor_groups, null)
	
	_traits_control.set_disabled(false)
	_traits_control.populate_tree(p_record.traits, null)

func _on_FamilyNameLineEdit_text_changed( text ):
	if(current_record):
		current_record.family_name = text
		current_database.mark_database_as_modified()

func _on_GivenNameLineEdit_text_changed( text ):
	if(current_record):
		current_record.given_name = text
		current_database.mark_database_as_modified()

func _on_NicknameLineEdit_text_changed( text ):
	if(current_record):
		current_record.nickname = text
		current_database.mark_database_as_modified()

func _on_GenderOptionButton_item_selected( ID ):
	if(current_record):
		current_record.gender = ID
		current_database.mark_database_as_modified()

func _on_Day_value_changed( value ):
	if(current_record):
		current_record.date_of_birth_day = value
		current_database.mark_database_as_modified()

func _on_Month_item_selected( ID ):
	if(current_record):
		current_record.date_of_birth_month = ID + 1
		current_database.mark_database_as_modified()

func _on_AgeSpinbox_value_changed( value ):
	if(current_record):
		current_record.age = value
		current_database.mark_database_as_modified()

func _on_BloodTypeControl_item_selected( ID ):
	if(current_record):
		current_record.bloodtype = ID
		current_database.mark_database_as_modified()


func _on_ActorGroupsControl_record_erased( p_record ):
	if(current_record):
		if(current_record.actor_groups.find(p_record) != -1):
			current_record.actor_groups.erase(p_record)
			_actor_groups_control.populate_tree(current_record.actor_groups, null)
			current_database.mark_database_as_modified()

func _on_ActorGroupsControl_record_selected( p_record ):
	if(current_record and current_record != p_record):
		if(current_record.actor_groups.find(p_record) != -1):
			return
		else:
			current_record.actor_groups.append(p_record)
			_actor_groups_control.populate_tree(current_record.actor_groups, null)
			current_database.mark_database_as_modified()

func _on_TraitsControl_record_erased( p_record ):
	if(current_record):
		if(current_record.traits.find(p_record) != -1):
			current_record.traits.erase(p_record)
			_traits_control.populate_tree(current_record.traits, null)
			current_database.mark_database_as_modified()

func _on_TraitsControl_record_selected( p_record ):
	if(current_record and current_record != p_record):
		if(current_record.traits.find(p_record) != -1):
			return
		else:
			current_record.traits.append(p_record)
			_traits_control.populate_tree(current_record.traits, null)
			current_database.mark_database_as_modified()
