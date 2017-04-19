tool
extends "database_panel.gd"

const headpart_record_const = preload("../databases/headpart_record.gd")

export(NodePath) var headpart_type_control = NodePath()
export(NodePath) var meshpart_control = NodePath()
export(NodePath) var stamp_control = NodePath()
export(NodePath) var main_icon_path_control = NodePath()
export(NodePath) var main_icon_preview_control = NodePath()
export(NodePath) var character_creator_enabled_control = NodePath()

export(NodePath) var headpart_preview = NodePath()

onready var _headpart_type_control_node = get_node(headpart_type_control)
onready var _meshpart_control_node = get_node(meshpart_control)
onready var _stamp_control_node = get_node(stamp_control)
onready var _main_icon_path_control_node = get_node(main_icon_path_control)
onready var _main_icon_preview_control_node = get_node(main_icon_preview_control)
onready var _character_creator_enabled_control = get_node(character_creator_enabled_control)

onready var _headpart_preview = get_node(headpart_preview)

func _ready():
	pass

func galatea_databases_assigned():
	.galatea_databases_assigned()
	
	current_database = galatea_databases.headpart_database
	
	var headpart_type_popup = _headpart_type_control_node.get_popup()
	
	headpart_type_popup.clear()
	for i in range(0, headpart_record_const.HEADPART_MAX):
		headpart_type_popup.add_item(headpart_record_const.get_string_from_headpart(i), i) 
	if(!headpart_type_popup.is_connected("item_pressed", self, "_on_headpart_type_selected")):
		headpart_type_popup.connect("item_pressed", self, "_on_headpart_type_selected")
	
	_meshpart_control_node.assign_database(galatea_databases.meshpart_database)
	_stamp_control_node.assign_database(galatea_databases.stamp_database)
	
	if(current_database != null):
		database_records.populate_tree(current_database, null)
	else:
		printerr("headpart_database is null")

func set_current_record_callback(p_record):
	.set_current_record_callback(p_record)
	
	_headpart_type_control_node.set_text(headpart_record_const.get_string_from_headpart(p_record.headpart_type))
	_headpart_type_control_node.set_disabled(false)
	
	_meshpart_control_node.set_disabled(false)
	if(p_record.meshpart):
		_meshpart_control_node.set_record_name(p_record.meshpart.id)
	else:
		_meshpart_control_node.set_record_name("")
	
	_character_creator_enabled_control.set_disabled(false)
	_character_creator_enabled_control.set_pressed(p_record.character_creator_enabled)
	
	##
	_main_icon_path_control_node.set_file_path(current_record.main_icon_path)
	_main_icon_path_control_node.set_disabled(false)
	
	_main_icon_preview_control_node.set_texture(null)
	var main_icon_texture = null
	if(!p_record.main_icon_path.empty()):
		main_icon_texture = load(p_record.main_icon_path)
	if(main_icon_texture):
		if(main_icon_texture extends Texture):
			_main_icon_preview_control_node.set_texture(main_icon_texture)
	##
	
	setup_headpart_preview()
	
	_stamp_control_node.set_disabled(false)
	if(p_record.stamp):
		_stamp_control_node.set_record_name(p_record.stamp.id)
	else:
		_stamp_control_node.set_record_name("")
	##

func _on_headpart_type_selected( p_id ):
	if(current_record):
		current_record.headpart_type = p_id
		_headpart_type_control_node.set_text(headpart_record_const.get_string_from_headpart(current_record.headpart_type))
		current_database.mark_database_as_modified()

func _on_StampControl_record_selected( p_record ):
	if(current_record):
		current_record.stamp = p_record
		setup_headpart_preview()
		current_database.mark_database_as_modified()
		
func _on_StampControl_record_erased( p_record ):
	if(current_record):
		current_record.stamp = p_record
		setup_headpart_preview()
		current_database.mark_database_as_modified()
		

func setup_headpart_preview():
	if(current_record.meshpart != null and current_record.meshpart.mesh_path != ""):
		var mesh = load(current_record.meshpart.mesh_path)
		if(mesh and mesh extends Mesh):
			var texture = null
			var material = null
			
			if(current_record.stamp):
				if(current_record.stamp.texture_set):
					texture = load(current_record.stamp.texture_set.textures["diffuse"])
			
			if(texture and texture extends Texture):
				material = FixedMaterial.new()
				material.set_texture(FixedMaterial.PARAM_DIFFUSE, texture)

			if(_headpart_preview):
				_headpart_preview.set_mesh(mesh)
				_headpart_preview.set_material(material)
		else:
			_headpart_preview.set_mesh(null)
			_headpart_preview.set_material(null)
	else:
		_headpart_preview.set_mesh(null)
		_headpart_preview.set_material(null)
			
func _on_MeshpartControl_record_selected( p_record ):
	if(current_record and current_record != p_record):
		current_record.meshpart = p_record
		setup_headpart_preview()
		current_database.mark_database_as_modified()
		
func _on_MeshpartControl_record_erased( p_record ):
	if(current_record and current_record != p_record):
		current_record.meshpart = p_record
		setup_headpart_preview()
		current_database.mark_database_as_modified()
		
func _on_CharacterCreatorCheckBox_toggled( pressed ):
	if(current_record):
		current_record.character_creator_enabled = pressed
		current_database.mark_database_as_modified()

func _on_MainIconPathContainer_file_selected( p_path ):
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
