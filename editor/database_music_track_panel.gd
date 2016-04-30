tool
extends "database_panel.gd"

var track_title_control = null
var track_artist_control = null
var track_file_path_control = null
var playable_on_phone_music_app_control = null

#
var database_records = null

func _ready():
	track_title_control = get_node("RightSide/TrackTitleVBoxContainer/TrackTitleControl")
	assert(track_title_control)
	
	track_artist_control = get_node("RightSide/TrackArtistVBoxContainer/TrackArtistControl")
	assert(track_artist_control)
	
	track_file_path_control = get_node("RightSide/TrackFilePathControl")
	assert(track_file_path_control)
	
	playable_on_phone_music_app_control = get_node("RightSide/PlayableOnPhoneMusicAppVBoxContainer/PlayableOnPhoneMusicAppControlContainer/PlayableOnPhoneMusicAppControl")
	assert(playable_on_phone_music_app_control)
	
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
	
	current_database = galatea_databases.music_track_database
	
	if(current_database != null):
		database_records.populate_tree(current_database, null)
	else:
		printerr("music_track_databases is null")

func set_current_record_callback(p_record):
	.set_current_record_callback(p_record)
	
	track_title_control.set_text(current_record.track_title)
	track_title_control.set_editable(true)
	
	track_artist_control.set_text(current_record.track_artist)
	track_artist_control.set_editable(true)
	
	track_file_path_control.set_file_path(current_record.track_path)
	track_file_path_control.set_disabled(false)
	
	playable_on_phone_music_app_control.set_pressed(p_record.playable_on_phone_music_app)
	playable_on_phone_music_app_control.set_disabled(false)

func _on_TrackTitleControl_text_changed( text ):
	if(current_record):
		current_record.track_title = text
		current_database.mark_database_as_modified()


func _on_TrackArtistControl_text_changed( text ):
	if(current_record):
		current_record.track_artist = text
		current_database.mark_database_as_modified()


func _on_TrackFilePathControl_file_selected( p_path ):
	if(current_record):
		current_record.track_path = p_path
		current_database.mark_database_as_modified()

func _on_PlayableOnPhoneMusicAppControl_toggled( pressed ):
	if(current_record):
		current_record.playable_on_phone_music_app = pressed
		current_database.mark_database_as_modified()
