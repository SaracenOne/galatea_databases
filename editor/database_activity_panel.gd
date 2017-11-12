tool
extends "database_panel.gd"

export(NodePath) var printed_name_control = NodePath()
export(NodePath) var description_control = NodePath()
export(NodePath) var main_icon_path_control = NodePath()
export(NodePath) var main_icon_preview_control = NodePath()
export(NodePath) var activity_script_path_control = NodePath()
export(NodePath) var valid_locations_control = NodePath()
export(NodePath) var selectable_flag_control = NodePath()

onready var _printed_name_control_node = get_node(printed_name_control)
onready var _description_control_node = get_node(description_control)
onready var _main_icon_path_control_node = get_node(main_icon_path_control)
onready var _main_icon_preview_control_node = get_node(main_icon_preview_control)
onready var _activity_script_path_control_node = get_node(activity_script_path_control)
onready var _valid_locations_control_node = get_node(valid_locations_control)
onready var _selectable_flag_control_node = get_node(selectable_flag_control)

func _ready():
	pass
	
func editor_plugin_assigned():
	pass

func galatea_databases_assigned():
	.galatea_databases_assigned()
	
	current_database = galatea_databases.activity_database
	if(current_database != null):
		database_records.populate_tree(current_database, null)
		_valid_locations_control_node.assign_database(galatea_databases.location_database)
	else:
		printerr("activity_database is null")

func set_current_record_callback(p_record):
	.set_current_record_callback(p_record)
	
	_printed_name_control_node.set_text(current_record.printed_name)
	_printed_name_control_node.set_editable(true)
	
	_description_control_node.set_text(current_record.description)
	_description_control_node.set_editable(true)
	
	_main_icon_path_control_node.set_file_path(current_record.main_icon_path)
	_main_icon_path_control_node.set_disabled(false)
	
	_main_icon_preview_control_node.set_texture(null)
	var main_icon_texture = null
	if(!p_record.main_icon_path.empty()):
		main_icon_texture = load(p_record.main_icon_path)
	if(main_icon_texture):
		if(main_icon_texture is Texture):
			_main_icon_preview_control_node.set_texture(main_icon_texture)
	
	_activity_script_path_control_node.set_file_path(current_record.activity_script_path)
	_activity_script_path_control_node.set_disabled(false)
	
	_valid_locations_control_node.set_disabled(false)
	_valid_locations_control_node.populate_tree(p_record.valid_locations, null)
	
	_selectable_flag_control_node.set_pressed(current_record.selectable)
	_selectable_flag_control_node.set_disabled(false)
	
func _on_ValidLocationsRecordsReference_record_selected( p_record ):
	if(current_record and current_record != p_record):
		if(current_record.valid_locations.find(p_record) != -1):
			return
		else:
			current_record.valid_locations.append(p_record)
			_valid_locations_control_node.populate_tree(current_record.valid_locations, null)
			current_database.mark_database_as_modified()

func _on_ValidLocationsRecordsReference_record_erased( p_record ):
	if(current_record):
		if(current_record.valid_locations.find(p_record) != -1):
			current_record.valid_locations.erase(p_record)
			_valid_locations_control_node.populate_tree(current_record.valid_locations, null)
			current_database.mark_database_as_modified()

func _on_ActivityScriptPath_file_selected( p_path ):
	if(current_record):
		current_record.activity_script_path = p_path
		current_database.mark_database_as_modified()
		
func _on_PrintedNameLineEdit_text_changed( text ):
	if(current_record):
		current_record.printed_name = text
		current_database.mark_database_as_modified()

func _on_DescriptionLineEdit_text_changed( text ):
	if(current_record):
		current_record.description = text
		current_database.mark_database_as_modified()
		
func _on_SelectableFlagCheckBox_toggled( pressed ):
	if(current_record):
		current_record.selectable = pressed
		current_database.mark_database_as_modified()
		
func _on_MainIconPath_file_selected( p_path ):
	if(current_record):
		current_record.main_icon_path = p_path
		
		_main_icon_preview_control_node.set_texture(null)
		var main_icon_texture = null
		if(!p_path.empty()):
			main_icon_texture = load(p_path)
		if(main_icon_texture):
			if(main_icon_texture is Texture):
				_main_icon_preview_control_node.set_texture(main_icon_texture)
			
		current_database.mark_database_as_modified()