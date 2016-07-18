tool
extends "database_panel.gd"

export(NodePath) var family_name = NodePath()
export(NodePath) var given_name = NodePath()
export(NodePath) var nickname = NodePath()
export(NodePath) var gender = NodePath()
export(NodePath) var date_of_birth = NodePath()
export(NodePath) var age = NodePath()
export(NodePath) var blood_type = NodePath()
export(NodePath) var actor_groups = NodePath()
export(NodePath) var traits = NodePath()

export(NodePath) var contact_icon_path = NodePath()
export(NodePath) var contact_icon_texture = NodePath()

export(NodePath) var valid_contact = NodePath()
export(NodePath) var is_storyline_actor = NodePath()

onready var _family_name_control = get_node(family_name)
onready var _given_name_control = get_node(given_name)
onready var _nickname_control = get_node(nickname)
onready var _gender_control = get_node(gender)

onready var _date_of_birth = get_node(date_of_birth)

onready var _age_control = get_node(age)
onready var _blood_type_control = get_node(blood_type)

onready var _actor_groups_control = get_node(actor_groups)
onready var _traits_control = get_node(traits)

onready var _contact_icon_path_control = get_node(contact_icon_path)
onready var _contact_icon_texture_control = get_node(contact_icon_texture)

onready var _valid_contact_control = get_node(valid_contact)
onready var _is_storyline_actor_control = get_node(is_storyline_actor)

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
	
	_date_of_birth.set_disabled(false)
	_date_of_birth.set_day(p_record.date_of_birth_day)
	_date_of_birth.set_month(p_record.date_of_birth_month - 1)
	
	_age_control.set_value(p_record.age)
	_age_control.set_editable(true)
	
	_blood_type_control.select(p_record.bloodtype)
	_blood_type_control.set_disabled(false)
	
	_actor_groups_control.set_disabled(false)
	_actor_groups_control.populate_tree(p_record.actor_groups, null)
	
	_traits_control.set_disabled(false)
	_traits_control.populate_tree(p_record.traits, null)
	
	_contact_icon_path_control.set_disabled(false)
	_contact_icon_path_control.set_file_path(p_record.contact_icon_path)
	_contact_icon_texture_control.set_texture(null)
	var contact_icon_texture = null
	if(!p_record.contact_icon_path.empty()):
		contact_icon_texture = load(p_record.contact_icon_path)
	if(contact_icon_texture):
		if(contact_icon_texture extends Texture):
			_contact_icon_texture_control.set_texture(contact_icon_texture)
	
	_valid_contact_control.set_disabled(false)
	_valid_contact_control.set_pressed(p_record.is_valid_contact)
	
	_is_storyline_actor_control.set_disabled(false)
	_is_storyline_actor_control.set_pressed(p_record.is_storyline_actor)

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
		
func _on_DateOfBirthOption_day_changed( p_day ):
	if(current_record):
		current_record.date_of_birth_day = p_day
		current_database.mark_database_as_modified()
		
func _on_DateOfBirthOption_month_changed( p_month ):
	if(current_record):
		current_record.date_of_birth_month = p_month + 1
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
			
func _on_ContactIconPathControl_file_selected( p_path ):
	if(current_record):
		current_record.contact_icon_path = p_path
		_contact_icon_texture_control.set_texture(null)
		var contact_icon_texture = null
		if(!p_path.empty()):
			contact_icon_texture = load(p_path)
		if(contact_icon_texture):
			if(contact_icon_texture extends Texture):
				_contact_icon_texture_control.set_texture(contact_icon_texture)
		
		current_database.mark_database_as_modified()
		
func _on_ValidContactCheckbox_toggled( pressed ):
	if(current_record):
		current_record.is_valid_contact = pressed
		current_database.mark_database_as_modified()

func _on_IsStorylineActorCheckbox_toggled( pressed ):
	if(current_record):
		current_record.is_storyline_actor = pressed
		current_database.mark_database_as_modified()

