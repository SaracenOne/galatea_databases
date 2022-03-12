@tool
extends "./database_panel.gd"

var currently_selected_texture = ""

@export var texture_path: NodePath  = NodePath()
@export var texture_tree: NodePath  = NodePath()
@export var texture_preview: NodePath  = NodePath()

@onready var _texture_path_control = get_node(texture_path)
@onready var _texture_tree_control = get_node(texture_tree)
@onready var _texture_preview_control = get_node(texture_preview)


func _ready():
	texture_path = NodePath("RightSide/TexturesContainer/TexturesContainerLeft/TexturesPathControl")
	texture_tree = NodePath("RightSide/TexturesContainer/TexturesContainerLeft/TexturesTree")
	texture_preview = NodePath("RightSide/TexturesContainer/TextureFramePanel/TextureFrame")

	_texture_path_control = get_node(texture_path)
	_texture_tree_control = get_node(texture_tree)
	_texture_preview_control = get_node(texture_preview)

func galatea_databases_assigned():
	super.galatea_databases_assigned()
	
	current_database = galatea_databases.texture_set_database
	if(current_database != null):
		database_records.populate_tree(current_database, null)
	else:
		printerr("texture_set_database is null")

func update_tree_data(p_retain_selection):
	if(current_record):
		var selection = _texture_tree_control.get_selected()
		var selection_metadata = ""
		if(selection):
			selection_metadata = selection.get_metadata(0)
			
		_texture_tree_control.clear()
		_texture_tree_control.set_hide_root(true)
		var root = _texture_tree_control.create_item(null)
		
		for key in current_record.textures:
			var item = _texture_tree_control.create_item(root)
			item.set_text(0, key)
			item.set_text(1, current_record.textures[key])
			item.set_metadata(0, key)
			if(p_retain_selection and key == selection_metadata):
				item.select(0)
			
func update_preview():
	if(current_record and currently_selected_texture != ""):
		_texture_preview_control.set_texture(null)
		var preview_texture = load(current_record.textures[currently_selected_texture])
		
		if(preview_texture):
			if(preview_texture is Texture):
				_texture_preview_control.set_texture(preview_texture)
	else:
		_texture_preview_control.set_texture(null)

func set_current_record_callback(p_record):
	super.set_current_record_callback(p_record)
	
	currently_selected_texture = ""
	_texture_path_control.set_file_path("")
	
	update_tree_data(false)
	update_preview()
	
func _on_TexturesTree_cell_selected():
	if(current_record):
		var selected = _texture_tree_control.get_selected()
		var metadata = selected.get_metadata(0)
		currently_selected_texture = metadata
		
		var texture_file_path = current_record.textures[metadata]
		_texture_path_control.set_disabled(false)
		_texture_path_control.set_file_path(texture_file_path)
		
		update_preview()

func _on_TexturesPathControl_file_selected( p_path ):
	if(current_record and currently_selected_texture != ""):
		current_record.textures[currently_selected_texture] = p_path
		
		update_preview()
		update_tree_data(true)
		
		current_database.mark_database_as_modified(current_database.DATABASE_NAME)
