@tool
extends "./database_panel.gd"

@export var printed_name_control: NodePath  = NodePath()
@export var description_control: NodePath  = NodePath()
@export var icon_file_control: NodePath  = NodePath()
@export var visible_in_character_creator: NodePath  = NodePath()
@export var contradictory_traits_control: NodePath  = NodePath()

@onready var _printed_name_control_node: LineEdit = get_node(printed_name_control)
@onready var _description_control_node: TextEdit = get_node(description_control)
@onready var _icon_file_control_node = get_node(icon_file_control)
@onready var _visible_in_character_creator_node = get_node(visible_in_character_creator)
@onready var _contradictory_traits_control_node = get_node(contradictory_traits_control)

func _ready():
	pass
	
func galatea_databases_assigned():
	super.galatea_databases_assigned()
	
	current_database = galatea_databases.trait_database
	if(current_database != null):
		database_records.populate_tree(current_database, null)
		_contradictory_traits_control_node.assign_database(current_database)
	else:
		printerr("location_database is null")

func set_current_record_callback(p_record):
	super.set_current_record_callback(p_record)
	
	_printed_name_control_node.set_text(p_record.printed_name)
	_printed_name_control_node.set_editable(true)
	
	_description_control_node.set_line_wrapping_mode(TextEdit.LINE_WRAPPING_BOUNDARY)
	_description_control_node.set_text(p_record.description)
	
	_icon_file_control_node.set_file_path(p_record.main_icon_path)
	_icon_file_control_node.set_disabled(false)
	
	_visible_in_character_creator_node.set_pressed(p_record.visible_in_character_creator)
	_visible_in_character_creator_node.set_disabled(false)
	
	_contradictory_traits_control_node.populate_tree(p_record.contradictory_traits, null)
	_contradictory_traits_control_node.set_disabled(false)
	
func _on_printed_name_text_changed( p_printed_name ):
	if(current_record):
		current_record.printed_name = p_printed_name
		current_database.mark_database_as_modified(current_database.DATABASE_NAME)
		
func _on_DescriptionControl_text_changed():
	if(current_record):
		current_record.description = _description_control_node.get_text()
		current_database.mark_database_as_modified(current_database.DATABASE_NAME)
		
func _on_IconFileMainContainer_file_selected( p_path ):
	if(current_record):
		current_record.main_icon_path = p_path
		current_database.mark_database_as_modified(current_database.DATABASE_NAME)

func _on_VisibleInCharacterControl_toggled( pressed ):
	if(current_record):
		current_record.visible_in_character_creator = pressed
		current_database.mark_database_as_modified(current_database.DATABASE_NAME)

func _on_ContradictoryTraitsControl_record_selected( p_record ):
	if(current_record and current_record != p_record):
		if(current_record.contradictory_traits.find(p_record) != -1):
			return
		else:
			current_record.contradictory_traits.append(p_record)
			_contradictory_traits_control_node.populate_tree(current_record.contradictory_traits, null)
			current_database.mark_database_as_modified(current_database.DATABASE_NAME)

func _on_ContradictoryTraitsControl_record_erased( p_record ):
	if(current_record):
		if(current_record.contradictory_traits.find(p_record) != -1):
			current_record.contradictory_traits.erase(p_record)
			_contradictory_traits_control_node.populate_tree(current_record.contradictory_traits, null)
			current_database.mark_database_as_modified(current_database.DATABASE_NAME)
