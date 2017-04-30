tool
extends "database_panel.gd"

const actor_record_const = preload("../databases/actor_record.gd")
const headpart_record_const = preload("../databases/headpart_record.gd")

var current_body_scaler_key = ""
var current_head_morph_key = ""
var current_stamp = ""

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
export(NodePath) var head_color = NodePath()
export(NodePath) var eyes = NodePath()
export(NodePath) var eyes_color = NodePath()
export(NodePath) var eyebrows = NodePath()
export(NodePath) var eyebrows_color = NodePath()
export(NodePath) var mouth = NodePath()
export(NodePath) var mouth_color = NodePath()
export(NodePath) var eyelashes = NodePath()
export(NodePath) var eyelashes_color = NodePath()

export(NodePath) var hair = NodePath()
export(NodePath) var hair_color = NodePath()

export(NodePath) var skin_color = NodePath()

export(NodePath) var head_morph_table = NodePath()
export(NodePath) var head_morph_value = NodePath()

export(NodePath) var body_scaler_table = NodePath()
export(NodePath) var body_scaler_value = NodePath()

export(NodePath) var stamp_table = NodePath()
export(NodePath) var stamp_color = NodePath()

export(NodePath) var body = NodePath()

export(NodePath) var height = NodePath()

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
onready var _head_color_control = get_node(head_color)
onready var _eyes_control = get_node(eyes)
onready var _eyes_color_control = get_node(eyes_color)
onready var _eyebrows_control = get_node(eyebrows)
onready var _eyebrows_color_control = get_node(eyebrows_color)
onready var _mouth_control = get_node(mouth)
onready var _mouth_color_control = get_node(mouth_color)
onready var _eyelashes_control = get_node(eyelashes)
onready var _eyelashes_color_control = get_node(eyelashes_color)

onready var _hair_control = get_node(hair)
onready var _hair_color_control = get_node(hair_color)

onready var _skin_color_control = get_node(skin_color)

onready var _head_morph_table_control = get_node(head_morph_table)
onready var _head_morph_value_control = get_node(head_morph_value)

onready var _body_scaler_table_control = get_node(body_scaler_table)
onready var _body_scaler_value_control = get_node(body_scaler_value)

onready var _stamp_table_control = get_node(stamp_table)
onready var _stamp_color_control = get_node(stamp_color)

onready var _body_control = get_node(body)

onready var _height_control = get_node(height)

func _ready():
	pass

func galatea_databases_assigned():
	.galatea_databases_assigned()
	
	current_database = galatea_databases.actor_database
	
	if(current_database != null):
		database_records.populate_tree(current_database, null)
		
		_actor_groups_control.assign_database(galatea_databases.actor_group_database)
		_traits_control.assign_database(galatea_databases.trait_database)
		_stamp_table_control.assign_database(galatea_databases.stamp_database)
		
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
		
		_hair_control.assign_database(galatea_databases.hair_database)
		_body_control.assign_database(galatea_databases.body_database)
		
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

	current_body_scaler_key = ""
	_body_scaler_value_control.set_step(0.0)
	_body_scaler_value_control.set_value(0.0)
	
	current_head_morph_key = ""
	_head_morph_value_control.set_step(0.0)
	_head_morph_value_control.set_value(0.0)

	var stamp_records = []
	for stamp in current_record.stamp_table.keys():
		stamp_records.append(stamp)

	_stamp_table_control.set_disabled(false)
	_stamp_table_control.populate_tree(stamp_records, null)

	current_stamp = null
	_stamp_color_control.set_color(Color(1.0, 1.0, 1.0))
	_stamp_color_control.set_disabled(true)

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
		_head_color_control.set_color(p_record.head_color)
		_head_color_control.set_disabled(false)
	else:
		_head_control.set_record_name("")
		_head_color_control.set_color(Color(1.0, 1.0, 1.0, 1.0))
		_head_color_control.set_disabled(true)
	_eyes_control.set_disabled(false)
	if(p_record.eyes):
		_eyes_control.set_record_name(p_record.eyes.id)
		_eyes_color_control.set_color(p_record.eyes_color)
		_eyes_color_control.set_disabled(false)
	else:
		_eyes_control.set_record_name("")
		_eyes_color_control.set_color(Color(1.0, 1.0, 1.0, 1.0))
		_eyes_color_control.set_disabled(true)
	_eyebrows_control.set_disabled(false)
	if(p_record.eyebrows):
		_eyebrows_control.set_record_name(p_record.eyebrows.id)
		_eyebrows_color_control.set_color(p_record.eyelashes_color)
		_eyebrows_color_control.set_disabled(false)
	else:
		_eyebrows_control.set_record_name("")
		_eyebrows_color_control.set_color(Color(1.0, 1.0, 1.0, 1.0))
		_eyebrows_color_control.set_disabled(true)
	_mouth_control.set_disabled(false)
	if(p_record.mouth):
		_mouth_control.set_record_name(p_record.mouth.id)
		_mouth_color_control.set_color(p_record.mouth_control)
		_mouth_color_control.set_disabled(false)
	else:
		_mouth_control.set_record_name("")
		_mouth_color_control.set_color(Color(1.0, 1.0, 1.0, 1.0))
		_mouth_color_control.set_disabled(true)
	_eyelashes_control.set_disabled(false)
	if(p_record.eyelashes):
		_eyelashes_control.set_record_name(p_record.eyelashes.id)
		_eyelashes_control.set_color(p_record.eyelashes_control)
	else:
		_eyelashes_control.set_record_name("")
		_eyelashes_color_control.set_color(Color(1.0, 1.0, 1.0, 1.0))
		_eyelashes_color_control.set_disabled(true)

	_hair_control.set_disabled(false)
	if(p_record.hair):
		_hair_control.set_record_name(p_record.hair.id)
	else:
		_hair_control.set_record_name("")

	_hair_color_control.set_disabled(false)
	_hair_color_control.set_color(p_record.hair_color)

	_skin_color_control.set_disabled(false)
	_skin_color_control.set_color(p_record.skin_color)

	_body_control.set_disabled(false)
	if(p_record.body):
		_body_control.set_record_name(p_record.body.id)
	else:
		_body_control.set_record_name("")
		
	_height_control.set_value(p_record.height)
	_height_control.set_step(0.0001)
	_height_control.set_editable(true)
	
	update_body_scalers()
	update_morphs()
	
static func get_valid_body_scaler_key_list(p_record):
	if(p_record and p_record.body):
		if(p_record.gender == actor_record_const.GENDER_MALE):
			return p_record.body.body_scaler_male_table
		elif(p_record.gender == actor_record_const.GENDER_FEMALE):
			return p_record.body.body_scaler_female_table
			
	return []

func update_body_scalers():
	_body_scaler_table_control.clear()
	var root = _body_scaler_table_control.create_item(null)
	_body_scaler_table_control.set_hide_root(true)

	_body_scaler_value_control.set_value(0.0)
	_body_scaler_value_control.set_step(0.0)
	_body_scaler_value_control.set_editable(false)

	if(current_record):
		var body_scaler_dictionary = {}
		var body_scaler_array = get_valid_body_scaler_key_list(current_record)
		
		for body_scaler in body_scaler_array:
			if(current_record.body_scaler_table.keys().has(body_scaler.id)):
				body_scaler_dictionary[body_scaler.id] = current_record.body_scaler_table[body_scaler.id]
			else:
				body_scaler_dictionary[body_scaler.id] = body_scaler.default_value
				
			var tree_item = _head_morph_table_control.create_item(root)
			tree_item.set_cell_mode(0, TreeItem.CELL_MODE_STRING)
			tree_item.set_text(0, body_scaler.id)
			tree_item.set_metadata(0, body_scaler.id)

		current_record.body_scaler_table = body_scaler_dictionary

func update_morphs():
	_head_morph_table_control.clear()
	var root = _head_morph_table_control.create_item(null)
	_head_morph_table_control.set_hide_root(true)

	_head_morph_value_control.set_value(0.0)
	_head_morph_value_control.set_step(0.0)
	_head_morph_value_control.set_editable(false)

	if(current_record):
		var morph_dictionary = {}
		var morph_key_list = current_record.get_valid_blend_key_list()

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
		update_body_scalers()

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
				current_head_morph_key = tree_item.get_metadata(0)
				var value = current_record.head_morph_table[tree_item.get_metadata(0)]
				_head_morph_value_control.set_value(value)
				_head_morph_value_control.set_step(0.000001)
				_head_morph_value_control.set_editable(true)
				
func _on_ScalerTableTree_cell_selected():
	if(current_record):
		if(_body_scaler_table_control and _body_scaler_value_control):
			var tree_item = _body_scaler_table_control.get_selected()
			if(tree_item):
				current_body_scaler_key = tree_item.get_metadata(0)
				var value = current_record.body_scaler_table[tree_item.get_metadata(0)]
				_body_scaler_value_control.set_value(value)
				_body_scaler_value_control.set_step(0.000001)
				_body_scaler_value_control.set_editable(true)

func _on_MorphTableSpinBox_value_changed( value ):
	if(current_record):
		if(_head_morph_value_control):
			if(_head_morph_value_control != ""):
				if(current_record.head_morph_table.has(current_head_morph_key) == true):
					current_record.head_morph_table[current_head_morph_key] = value
					current_database.mark_database_as_modified()

func _on_ScalerTableSpinBox_value_changed( value ):
	if(current_record):
		if(_body_scaler_value_control):
			if(current_body_scaler_key != ""):
				if(current_record.body_scaler_table.has(current_body_scaler_key) == true):
					current_record.body_scaler_table[current_body_scaler_key] = value
					current_database.mark_database_as_modified()

func _on_HairRecord_record_erased( p_record ):
	if(current_record):
		current_database.mark_database_as_modified()

func _on_HairRecord_record_selected( p_record ):
	if(current_record):
		current_record.hair = p_record
		current_database.mark_database_as_modified()

func _on_HairColorPicker_color_changed( color ):
	if(current_record):
		current_record.hair_color = color
		current_database.mark_database_as_modified()

func _on_SkinToneColorPicker_color_changed( color ):
	if(current_record):
		current_record.skin_color = color
		current_database.mark_database_as_modified()
		
func _on_StampColorButton_color_changed( color ):
	if(current_record):
		if(_stamp_color_control):
			if(current_stamp != null):
				if(current_record.stamp_table.has(current_stamp) == true):
					current_record.stamp_table[current_stamp] = color
					current_database.mark_database_as_modified()
					
func _on_HeadMeshColor_color_changed( color ):
	if(current_record):
		if(_head_color_control):
			current_record.head_color = color
			current_database.mark_database_as_modified()
			
func _on_EyesMeshColor_color_changed( color ):
	if(current_record):
		if(_eyes_color_control):
			current_record.eyes_color = color
			current_database.mark_database_as_modified()
			
func _on_EyebrowsMeshColo_color_changed( color ):
	if(current_record):
		if(_eyebrows_color_control):
			current_record.eyebrows_color = color
			current_database.mark_database_as_modified()
			
func _on_MouthMeshColor_color_changed( color ):
	if(current_record):
		if(_mouth_color_control):
			current_record.mouth_color = color
			current_database.mark_database_as_modified()
			
func _on_EyelashesColor_color_changed( color ):
	if(current_record):
		if(_eyelashes_color_control):
			current_record.eyelashes_color = color
			current_database.mark_database_as_modified()
		
func _on_BodyControl_record_selected( p_record ):
	if(current_record):
		current_record.body = p_record
		current_database.mark_database_as_modified()
		
func _on_BodyControl_record_erased( p_record ):
	if(current_record):
		current_record.body = p_record
		current_database.mark_database_as_modified()

func _on_StampTabelControl_record_selected( p_record ):
	if(current_record and current_record != p_record):
		if(current_record.stamp_table.has(p_record) == true):
			return
		else:
			current_record.stamp_table[p_record] = Color(1.0, 1.0, 1.0)
			
			var stamp_records = []
			for stamp in current_record.stamp_table.keys():
				var record = galatea_databases.stamp_database.find_record_by_name(stamp.id)
				if(record):
					stamp_records.append(record)
					
			current_stamp = null
			_stamp_color_control.set_color(Color(1.0, 1.0, 1.0))
			_stamp_color_control.set_disabled(false)
			
			_stamp_table_control.populate_tree(stamp_records, null)
			current_database.mark_database_as_modified()

func _on_StampTabelControl_record_cell_selected( p_record ):
	if(current_record):
		current_stamp = p_record
		if(current_record.stamp_table.has(p_record) == true):
			_stamp_color_control.set_color(current_record.stamp_table[p_record])
		else:
			_stamp_color_control.set_color(Color(1.0, 1.0, 1.0))
		_stamp_color_control.set_disabled(false)
	else:
		current_stamp = null
		
func _on_StampTabelControl_record_erased( p_record ):
	if(current_record):
		if(current_record.stamp_table.has(p_record) == true):
			current_record.stamp_table.erase(p_record)
			
			var stamp_records = []
			for stamp in current_record.stamp_table.keys():
				var record = galatea_databases.stamp_database.find_record_by_name(stamp.id)
				if(record):
					stamp_records.append(record)
					
			current_stamp = null
			_stamp_color_control.set_color(Color(1.0, 1.0, 1.0))
			_stamp_color_control.set_disabled(true)
			
			_stamp_table_control.populate_tree(stamp_records, null)
			current_database.mark_database_as_modified()
			
func _on_HeightSpinBox_value_changed( value ):
	if(current_record):
		current_record.height = value
		current_database.mark_database_as_modified()