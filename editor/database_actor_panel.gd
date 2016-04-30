tool
extends "database_panel.gd"

var family_name_control = null
var given_name_control = null
var nickname_control = null
var gender_control = null

var date_of_birth_day_control = null
var date_of_birth_month_control = null

var age_control = null
var blood_type_control = null

var actor_groups_control = null
var traits_control = null

#
var database_records = null

func _ready():
	family_name_control = get_node("RightSide/FamilyNameVBoxContainer/FamilyNameLineEdit")
	assert(family_name_control)
	
	given_name_control = get_node("RightSide/GivenNameVBoxContainer/GivenNameLineEdit")
	assert(given_name_control)
	
	nickname_control = get_node("RightSide/NicknameVBoxContainer/NicknameLineEdit")
	assert(nickname_control)
	
	gender_control = get_node("RightSide/GenderVBoxContainer/GenderOptionButton")
	assert(gender_control)
	
	date_of_birth_day_control = get_node("RightSide/DateOfBirthVBoxContainer/DateOfBirthOptions/Day")
	assert(date_of_birth_day_control)
	
	date_of_birth_month_control = get_node("RightSide/DateOfBirthVBoxContainer/DateOfBirthOptions/Month")
	assert(date_of_birth_month_control)
	
	age_control = get_node("RightSide/AgeVBoxContainer/AgeControl")
	assert(age_control)
	
	blood_type_control = get_node("RightSide/BloodTypeVBoxContainer/BloodTypeControl")
	assert(blood_type_control)
	
	actor_groups_control = get_node("RightSide/ActorGroupsContainer/ActorGroupsControl")
	assert(actor_groups_control)
	
	traits_control = get_node("RightSide/TraitsContainer/TraitsControl")
	assert(traits_control)
	
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
		actor_groups_control.assign_database(galatea_databases.actor_group_database)
		traits_control.assign_database(galatea_databases.trait_database)
	else:
		printerr("actor_databases is null")

func set_current_record_callback(p_record):
	.set_current_record_callback(p_record)
	
	family_name_control.set_text(current_record.family_name)
	family_name_control.set_editable(true)
	
	given_name_control.set_text(current_record.given_name)
	given_name_control.set_editable(true)
	
	nickname_control.set_text(current_record.nickname)
	nickname_control.set_editable(true)
	
	gender_control.select(current_record.gender)
	gender_control.set_disabled(false)
	
	date_of_birth_day_control.set_value(p_record.date_of_birth_day)
	date_of_birth_day_control.set_editable(true)
	
	date_of_birth_month_control.select(p_record.date_of_birth_month - 1)
	date_of_birth_month_control.set_disabled(false)
	
	age_control.set_value(p_record.age)
	age_control.set_editable(true)
	
	blood_type_control.select(p_record.bloodtype)
	blood_type_control.set_disabled(false)
	
	actor_groups_control.set_disabled(false)
	actor_groups_control.populate_tree(p_record.actor_groups, null)
	
	traits_control.set_disabled(false)
	traits_control.populate_tree(p_record.traits, null)

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
			actor_groups_control.populate_tree(current_record.actor_groups, null)
			current_database.mark_database_as_modified()

func _on_ActorGroupsControl_record_selected( p_record ):
	if(current_record and current_record != p_record):
		if(current_record.actor_groups.find(p_record) != -1):
			return
		else:
			current_record.actor_groups.append(p_record)
			actor_groups_control.populate_tree(current_record.actor_groups, null)
			current_database.mark_database_as_modified()

func _on_TraitsControl_record_erased( p_record ):
	if(current_record):
		if(current_record.traits.find(p_record) != -1):
			current_record.traits.erase(p_record)
			traits_control.populate_tree(current_record.traits, null)
			current_database.mark_database_as_modified()

func _on_TraitsControl_record_selected( p_record ):
	if(current_record and current_record != p_record):
		if(current_record.traits.find(p_record) != -1):
			return
		else:
			current_record.traits.append(p_record)
			traits_control.populate_tree(current_record.traits, null)
			current_database.mark_database_as_modified()
