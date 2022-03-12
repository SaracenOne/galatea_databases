@tool
extends "./database_panel.gd"

@export var track_title: NodePath  = NodePath()
@export var track_artist: NodePath  = NodePath()
@export var track_file_path: NodePath  = NodePath()
@export var loop_start: NodePath  = NodePath()
@export var contains_loop: NodePath  = NodePath()
@export var playable_on_music_player: NodePath  = NodePath()
@export var conditionals: NodePath  = NodePath()

@onready var _track_title_control = get_node(track_title)
@onready var _track_artist_control = get_node(track_artist)
@onready var _track_file_path_control = get_node(track_file_path)
@onready var _loop_start_control = get_node(loop_start)
@onready var _contains_loop_control = get_node(contains_loop)
@onready var _playable_on_music_player_control = get_node(playable_on_music_player)
@onready var _conditionals_control = get_node(conditionals)

func _ready():
	pass

func galatea_databases_assigned():
	super.galatea_databases_assigned()
	
	current_database = galatea_databases.music_track_database
	
	if(current_database != null):
		database_records.populate_tree(current_database, null)
	else:
		printerr("music_track_databases is null")

func set_current_record_callback(p_record):
	super.set_current_record_callback(p_record)
	
	_track_title_control.set_text(current_record.track_title)
	_track_title_control.set_editable(true)
	
	_track_artist_control.set_text(current_record.track_artist)
	_track_artist_control.set_editable(true)
	
	_track_file_path_control.set_file_path(current_record.track_path)
	_track_file_path_control.set_disabled(false)
	
	_loop_start_control.set_value(p_record.loop_start)
	_loop_start_control.set_step(0.0000001)
	_loop_start_control.set_editable(true)
	
	_contains_loop_control.set_pressed(p_record.contains_loop)
	_contains_loop_control.set_disabled(false)
	
	_playable_on_music_player_control.set_pressed(p_record.playable_on_music_player)
	_playable_on_music_player_control.set_disabled(false)
	
	_conditionals_control.assign_conditionals(current_record.conditionals)
	_conditionals_control.set_disabled(false)

func _on_TrackTitleControl_text_changed( text ):
	if(current_record):
		current_record.track_title = text
		current_database.mark_database_as_modified(current_database.DATABASE_NAME)

func _on_TrackArtistControl_text_changed( text ):
	if(current_record):
		current_record.track_artist = text
		current_database.mark_database_as_modified(current_database.DATABASE_NAME)

func _on_TrackFilePathControl_file_selected( p_path ):
	if(current_record):
		current_record.track_path = p_path
		current_database.mark_database_as_modified(current_database.DATABASE_NAME)

func _on_PlayableOnPhoneMusicAppControl_toggled( pressed ):
	if(current_record):
		current_record.playable_on_music_player = pressed
		current_database.mark_database_as_modified(current_database.DATABASE_NAME)

func _on_ContainsLoopControl_toggled( pressed ):
	if(current_record):
		current_record.contains_loop = pressed
		current_database.mark_database_as_modified(current_database.DATABASE_NAME)

func _on_DatabaseConditionalList_conditionals_changed( p_conditionals ):
	if(current_record):
		current_record.conditionals = p_conditionals
		current_database.mark_database_as_modified(current_database.DATABASE_NAME)

func _on_LoopStartControl_value_changed( value ):
	if(current_record):
		current_record.loop_start = value
		current_database.mark_database_as_modified(current_database.DATABASE_NAME)
