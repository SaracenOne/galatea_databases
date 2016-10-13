tool
extends "database_panel.gd"

const headpart_record_const = preload("../databases/headpart_record.gd")

var current_body_scaler_key = ""

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

export(NodePath) var head = NodePath()
export(NodePath) var eyes = NodePath()
export(NodePath) var eyebrows = NodePath()
export(NodePath) var mouth = NodePath()
export(NodePath) var eyelashes = NodePath()

export(NodePath) var head_morph_table = NodePath()
export(NodePath) var head_morph_value = NodePath()

export(NodePath) var body_scaler_table = NodePath()
export(NodePath) var body_scaler_value = NodePath()


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

onready var _head_control = get_node(head)
onready var _eyes_control = get_node(eyes)
onready var _eyebrows_control = get_node(eyebrows)
onready var _mouth_control = get_node(mouth)
onready var _eyelashes_control = get_node(eyelashes)

onready var _head_morph_table_control = get_node(head_morph_table)
onready var _head_morph_value_control = get_node(head_morph_value)

onready var _body_scaler_table_control = get_node(body_scaler_table)
onready var _body_scaler_value_control = get_node(body_scaler_value)

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
		_body_scaler_table_control.assign_database(galatea_databases.body_scaler_database)
		
		_head_control.assign_database(galatea_databases.headpart_database)
		_head_control.clear_rules()
		_head_control.assign_rule({"method":"is_headpart_type", "arg0":headpart_record_const.HEADPART_HEAD})
		
		_eyes_control.assign_database(galatea_databases.headpart_database)
		_eyes_control.clear_rules()
		_eyes_control.assign_rule({"method":"is_headpart_type", "arg0":headpart_record_const.HEADPART_EYES})
		
		_eyebrows_control.assign_database(galatea_databases.headpart_database)
		_eyebrows_control.clear_rules()
		_eyebrows_control.assign_rule({"method":"is_headpart_type", "arg0":headpart_record_const.HEADPART_EYEBROWS})
		
		_mouth_control.assign_database(galatea_databases.headpart_database)
		_mouth_control.clear_rules()
		_mouth_control.assign_rule({"method":"is_headpart_type", "arg0":headpart_record_const.HEADPART_MOUTH})
		
		_eyelashes_control.assign_database(galatea_databases.headpart_database)
		_eyelashes_control.clear_rules()
		_eyelashes_control.assign_rule({"method":"is_headpart_type", "arg0":headpart_record_const.HEADPART_EYELASHES})
		
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
	_age_control.set_step(1)
	_age_control.set_editable(true)
	
	_blood_type_control.select(p_record.bloodtype)
	_blood_type_control.set_disabled(false)
	
	_actor_groups_control.set_disabled(false)
	_actor_groups_control.populate_tree(p_record.actor_groups, null)
	
	_traits_control.set_disabled(false)
	_traits_control.populate_tree(p_record.traits, null)
	
	var body_scaler_records = []
	for body_scaler_key in p_record.body_scaler_table.keys():
		var record = galatea_databases.body_scaler_database.find_record_by_name(body_scaler_key)
		if(record):
			body_scaler_records.append(galatea_databases.body_scaler_database.find_record_by_name(body_scaler_key))
	
	_body_scaler_table_control.set_disabled(false)
	_body_scaler_table_control.populate_tree(body_scaler_records, null)
	
	current_body_scaler_key = ""
	_body_scaler_value_control.set_step(0.0)
	_body_scaler_value_control.set_value(0.0)
	
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
	
	_head_control.set_disabled(false)
	if(p_record.head):
		_head_control.set_record_name(p_record.head.id)
	else:
		_head_control.set_record_name("")
	_eyes_control.set_disabled(false)
	if(p_record.eyes):
		_eyes_control.set_record_name(p_record.eyes.id)
	else:
		_eyes_control.set_record_name("")
	_eyebrows_control.set_disabled(false)
	if(p_record.eyebrows):
		_eyebrows_control.set_record_name(p_record.eyebrows.id)
	else:
		_eyebrows_control.set_record_name("")
	_mouth_control.set_disabled(false)
	if(p_record.mouth):
		_mouth_control.set_record_name(p_record.mouth.id)
	else:
		_mouth_control.set_record_name("")
	_eyelashes_control.set_disabled(false)
	if(p_record.eyelashes):
		_eyelashes_control.set_record_name(p_record.eyelashes.id)
	else:
		_eyelashes_control.set_record_name("")
	
	update_body_scalers()
	update_morphs()
	
static func get_valid_morph_key_list(p_record):
	var morph_key_list = []
	var morph_paths = []
	
	if(p_record):
		if(p_record.head and p_record.head.gen_morph_path):
			morph_paths.append(p_record.head.gen_morph_path)
		if(p_record.eyes and p_record.eyes.gen_morph_path):
			morph_paths.append(p_record.eyes.gen_morph_path)
		if(p_record.eyebrows and p_record.eyebrows.gen_morph_path):
			morph_paths.append(p_record.eyebrows.gen_morph_path)
		if(p_record.eyelashes and p_record.eyelashes.gen_morph_path):
			morph_paths.append(p_record.eyelashes.gen_morph_path)
			
		for morph_path in morph_paths:
			var morph_data_collection = load(morph_path)
			if(morph_data_collection):
				for morph_data in morph_data_collection.morph_data_array:
					print(morph_data.name)
					if(!morph_key_list.has(morph_data.name)):
						morph_key_list.append(morph_data.name)
	
	return morph_key_list
						
func update_body_scalers():
	pass
				
func update_morphs():
	_head_morph_table_control.clear()
	var root = _head_morph_table_control.create_item(null)
	_head_morph_table_control.set_hide_root(true)
	
	_head_morph_value_control.set_value(0.0)
	_head_morph_value_control.set_step(0.0)
	_head_morph_value_control.set_editable(false)
	
	if(current_record):
		var morph_dictionary = {}
		var morph_key_list = get_valid_morph_key_list(current_record)
		
		for morph_key in morph_key_list:
			if(current_record.head_morph_table.keys().has(morph_key)):
				morph_dictionary[morph_key] = current_record.head_morph_table[morph_key]
			else:
				morph_dictionary[morph_key] = 0.0
				
			var tree_item = _head_morph_table_control.create_item(root)
			tree_item.set_cell_mode(0, TreeItem.CELL_MODE_STRING)
			tree_item.set_text(0, morph_key)
			tree_item.set_metadata(0, morph_key)
		
		current_record.head_morph_table = morph_dictionary

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
		
func _on_DateOfBirthOptions_month_changed( p_month ):
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

func _on_HeadMeshRecord_record_selected( p_record ):
	if(current_record and current_record != p_record):
		current_record.head = p_record
		current_database.mark_database_as_modified()

func _on_HeadMeshRecord_record_erased( p_record ):
	current_record.head = null
	current_database.mark_database_as_modified()

func _on_EyesMeshRecord_record_selected( p_record ):
	if(current_record and current_record != p_record):
		current_record.eyes = p_record
		current_database.mark_database_as_modified()

func _on_EyesMeshRecord_record_erased( p_record ):
	current_record.eyes = null
	current_database.mark_database_as_modified()

func _on_EyebrowsMeshRecord_record_selected( p_record ):
	if(current_record and current_record != p_record):
		current_record.eyebrows = p_record
		current_database.mark_database_as_modified()

func _on_EyebrowsMeshRecord_record_erased( p_record ):
	current_record.eyebrows = null
	current_database.mark_database_as_modified()

func _on_MouthMeshRecord_record_selected( p_record ):
	if(current_record and current_record != p_record):
		current_record.mouth = p_record
		current_database.mark_database_as_modified()

func _on_MouthMeshRecord_record_erased( p_record ):
	current_record.mouth = null
	current_database.mark_database_as_modified()

func _on_EyelashesMeshRecord_record_selected( p_record ):
	if(current_record and current_record != p_record):
		current_record.eyelashes = p_record
		current_database.mark_database_as_modified()

func _on_EyelashesMeshRecord_record_erased( p_record ):
	current_record.eyelashes = null
	current_database.mark_database_as_modified()

func _on_MorphTableTree_cell_selected():
	if(current_record):
		if(_head_morph_table_control and _head_morph_value_control):
			var tree_item = _head_morph_table_control.get_selected()
			if(tree_item):
				var value = current_record.head_morph_table[tree_item.get_metadata(0)]
				_head_morph_value_control.set_value(value)
				_head_morph_value_control.set_step(0.000001)
				_head_morph_value_control.set_editable(true)

func _on_MorphTableSpinBox_value_changed( value ):
	if(current_record):
		if(_head_morph_table_control and _head_morph_value_control):
			var tree_item = _head_morph_table_control.get_selected()
			if(tree_item):
				var name = tree_item.get_metadata(0)
				current_record.head_morph_table[name] = value


func _on_ScalerRemoveButton_button_down():
	if(current_record):
		if(_body_scaler_table_control and _body_scaler_value_control):
			var tree_item = _body_scaler_table_control.get_selected()
			if(tree_item):
				var name = tree_item.get_metadata(0)
				if(current_record.body_scaler_table.has(name)):
					current_record.body_scaler_table.remove(name)
					
					update_body_scalers()

func _on_ScalerTableSpinBox_value_changed( value ):
	if(current_record):
		if(_body_scaler_value_control):
			if(current_body_scaler_key != ""):
				if(current_record.body_scaler_table.has(current_body_scaler_key) == true):
					current_record.body_scaler_table[current_body_scaler_key] = value
					
					current_database.mark_database_as_modified()

func _on_ScalerTableControl_record_selected( p_record ):
	if(current_record and current_record != p_record):
		if(current_record.body_scaler_table.has(p_record.id) == true):
			return
		else:
			current_record.body_scaler_table[p_record.id] = 0.0
			
			var body_scaler_records = []
			for body_scaler_key in current_record.body_scaler_table.keys():
				var record = galatea_databases.body_scaler_database.find_record_by_name(body_scaler_key)
				if(record):
					body_scaler_records.append(galatea_databases.body_scaler_database.find_record_by_name(body_scaler_key))
					
			current_body_scaler_key = ""
			_body_scaler_value_control.set_step(0.0)
			_body_scaler_value_control.set_value(0.0)
			
			_body_scaler_table_control.populate_tree(body_scaler_records, null)
			current_database.mark_database_as_modified()

func _on_ScalerTableControl_record_erased( p_record ):
	if(current_record):
		if(current_record.body_scaler_table.has(p_record.id) == true):
			current_record.body_scaler_table.erase(p_record.id)
			
			var body_scaler_records = []
			for body_scaler_key in current_record.body_scaler_table.keys():
				var record = galatea_databases.body_scaler_database.find_record_by_name(body_scaler_key)
				if(record):
					body_scaler_records.append(galatea_databases.body_scaler_database.find_record_by_name(body_scaler_key))
			
			current_body_scaler_key = ""
			_body_scaler_value_control.set_step(0.0)
			_body_scaler_value_control.set_value(0.0)
			
			_body_scaler_table_control.populate_tree(body_scaler_records, null)
			current_database.mark_database_as_modified()

func _on_ScalerTableControl_record_cell_selected( p_record ):
	if(current_record):
		current_body_scaler_key = p_record.id
		
		if(current_record.body_scaler_table.has(p_record.id) == true):
			print(current_record.body_scaler_table[p_record.id])
			_body_scaler_value_control.set_value(current_record.body_scaler_table[p_record.id])
			_body_scaler_value_control.set_step(0.000001)
		else:
			_body_scaler_value_control.set_value(0.0)
			_body_scaler_value_control.set_step(0.0)
	else:
		current_body_scaler_key = ""
