tool
extends "database_panel.gd"

const hair_const = preload("res://addons/avatar/hair.gd")

export(NodePath) var printed_name_control = NodePath()
export(NodePath) var scene_file_control = NodePath()
export(NodePath) var physics_file_control = NodePath()

export(NodePath) var main_icon_path_control = NodePath()
export(NodePath) var main_icon_preview_control = NodePath()

export(NodePath) var character_creator_nodepath = NodePath()

export(NodePath) var male_nodepath = NodePath()
export(NodePath) var female_nodepath = NodePath()

export(NodePath) var scene_preview = NodePath()
export(NodePath) var capture_button = NodePath()

onready var _printed_name_control_node = get_node(printed_name_control)
onready var _scene_file_control_node = get_node(scene_file_control)
onready var _physics_file_control_node = get_node(physics_file_control)

onready var _main_icon_path_control_node = get_node(main_icon_path_control)
onready var _main_icon_preview_control_node = get_node(main_icon_preview_control)

onready var _character_creator_node = get_node(character_creator_nodepath)

onready var _male_node = get_node(male_nodepath)
onready var _female_node = get_node(female_nodepath)

onready var _scene_preview_node = get_node(scene_preview)
onready var _capture_button_node = get_node(capture_button)

func galatea_databases_assigned():
	.galatea_databases_assigned()
	
	current_database = galatea_databases.hair_database
	if(current_database != null):
		database_records.populate_tree(current_database, null)
	else:
		printerr("hair_database is null")
		
func update_icon_preview():
	_main_icon_preview_control_node.set_texture(null)
	var main_icon_texture = null
	if(current_record and current_record.main_icon_path.empty() == false):
		main_icon_texture = load(current_record.main_icon_path)
	if(main_icon_texture):
		if(main_icon_texture is Texture):
			_main_icon_preview_control_node.set_texture(main_icon_texture)
		
func orient_scene_preview():
	_scene_preview_node.rot_x = -20.0
	_scene_preview_node.rot_y = 45.0
	_scene_preview_node._update_rotation()
		
func update_scene_preview():
	if _scene_file_control_node and _scene_preview_node:
		_scene_preview_node.clear_scene()
		var file_path = _scene_file_control_node.get_file_path()
		var scene_file = load(file_path)
		if(scene_file != null and scene_file is PackedScene):
			var scene_instance = scene_file.instance()
			
			if(scene_instance):
				_scene_preview_node.set_scene(scene_instance)
			
			# Center camera
			_scene_preview_node.follow_target = Vector3()
			if scene_instance is hair_const:
				var mesh_instance = scene_instance.get_hair_mesh_instance()
				if mesh_instance:
					var aabb = mesh_instance.get_aabb()
					_scene_preview_node.follow_target = aabb.pos + aabb.size * 0.5
					_scene_preview_node.zoom = max(aabb.size.x,aabb.size.y)
					_scene_preview_node.zoom += _scene_preview_node.zoom
					orient_scene_preview()
				
func set_current_record_callback(p_record):
	.set_current_record_callback(p_record)
	
	_printed_name_control_node.set_text(current_record.printed_name)
	_printed_name_control_node.set_editable(true)
	
	_scene_file_control_node.set_file_path(current_record.scene_path)
	_scene_file_control_node.set_disabled(false)
	
	_physics_file_control_node.set_file_path(current_record.physics_path)
	_physics_file_control_node.set_disabled(false)
	
	_main_icon_path_control_node.set_file_path(current_record.main_icon_path)
	_main_icon_path_control_node.set_disabled(false)
	
	_character_creator_node.set_disabled(false)
	_character_creator_node.set_pressed(current_record.character_creator)
	
	_male_node.set_disabled(false)
	_male_node.set_pressed(current_record.male)
	
	_female_node.set_disabled(false)
	_female_node.set_pressed(current_record.female)
	
	_capture_button_node.set_disabled(false)
	_scene_preview_node.set_default_capture_filename(current_record.id + "_icon.png")
	
	update_icon_preview()
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
	
func _on_PhysicsFileMainContainer_file_selected( p_path ):
	if(current_record):
		current_record.physics_path = p_path
		current_database.mark_database_as_modified()
		
func _on_MainIconPath_file_selected( p_path ):
	if(current_record):
		current_record.main_icon_path = p_path
		
		update_icon_preview()
			
		current_database.mark_database_as_modified()

func _on_CreateIconButton_pressed():
	if _scene_preview_node and _capture_button_node:
		_scene_preview_node.save_preview_image()

func _on_OrientButton_pressed():
	orient_scene_preview()

func _on_CharacterCreatorCheckBox_toggled( pressed ):
	if(current_record):
		current_record.character_creator = pressed
		current_database.mark_database_as_modified()
		
func _on_MaleCheckbox_toggled( pressed ):
	if(current_record):
		current_record.male = pressed
		current_database.mark_database_as_modified()

func _on_FemaleCheckbox_toggled( pressed ):
	if(current_record):
		current_record.female = pressed
		current_database.mark_database_as_modified()
		
func _on_ScenePreview_image_saved():
	update_icon_preview()
