tool
extends "database_panel.gd"

export(NodePath) var printed_name_control = NodePath()
export(NodePath) var scene_file_control = NodePath()

export(NodePath) var main_icon_path_control = NodePath()
export(NodePath) var main_icon_preview_control = NodePath()

export(NodePath) var scene_preview = NodePath()

onready var _printed_name_control_node = get_node(printed_name_control)
onready var _scene_file_control_node = get_node(scene_file_control)

onready var _main_icon_path_control_node = get_node(main_icon_path_control)
onready var _main_icon_preview_control_node = get_node(main_icon_preview_control)

onready var _scene_preview_node = get_node(scene_preview)

func _ready():
	pass

func galatea_databases_assigned():
	.galatea_databases_assigned()
	
	current_database = galatea_databases.hair_database
	if(current_database != null):
		database_records.populate_tree(current_database, null)
	else:
		printerr("hair_database is null")
		
func update_scene_preview():
	if _scene_file_control_node and _scene_preview_node:
		_scene_preview_node.clear_scene()
		var file_path = _scene_file_control_node.get_file_path()
		var scene_file = load(file_path)
		if(scene_file != null and scene_file extends PackedScene):
			var scene_instance = scene_file.instance()
			if(scene_instance):
				_scene_preview_node.set_scene(scene_instance)
				
func set_current_record_callback(p_record):
	.set_current_record_callback(p_record)
	
	_printed_name_control_node.set_text(current_record.printed_name)
	_printed_name_control_node.set_editable(true)
	
	_scene_file_control_node.set_file_path(current_record.scene_path)
	_scene_file_control_node.set_disabled(false)
	
	_main_icon_path_control_node.set_file_path(current_record.main_icon_path)
	_main_icon_path_control_node.set_disabled(false)
	
	_main_icon_preview_control_node.set_texture(null)
	var main_icon_texture = null
	if(!p_record.main_icon_path.empty()):
		main_icon_texture = load(p_record.main_icon_path)
	if(main_icon_texture):
		if(main_icon_texture extends Texture):
			_main_icon_preview_control_node.set_texture(main_icon_texture)
			
	update_scene_preview()
	
func _on_printed_name_text_changed(p_printed_name):
	if(current_record):
		current_record.printed_name = p_printed_name
		current_database.mark_database_as_modified()
		
func _on_scene_file_selected(p_path):
	if(current_record):
		current_record.scene_path = p_path
		current_database.mark_database_as_modified()
		
		update_scene_preview()
		
func _on_MainIconPath_file_selected( p_path ):
	if(current_record):
		current_record.main_icon_path = p_path
		
		_main_icon_preview_control_node.set_texture(null)
		var main_icon_texture = null
		if(!p_path.empty()):
			main_icon_texture = load(p_path)
		if(main_icon_texture):
			if(main_icon_texture extends Texture):
				_main_icon_preview_control_node.set_texture(main_icon_texture)
			
		current_database.mark_database_as_modified()