@tool
extends "./generic_record.gd"

const conditionals_const = preload("../conditionals/conditionals.gd")

enum {TRACK_TYPE_SINGLE_TRACK, TRACK_TYPE_ASYNC_TRACK}

static func get_track_type_from_string(p_string):
	var upper_string = p_string.to_upper()
	
	if(upper_string == "SINGLE_TRACK"):
		return TRACK_TYPE_SINGLE_TRACK
	elif(upper_string == "ASYNC_TRACK"):
		return TRACK_TYPE_ASYNC_TRACK
	else:
		return -1
		
static func get_string_from_track_type(p_track_type):
	if(p_track_type == TRACK_TYPE_SINGLE_TRACK):
		return "SINGLE_TRACK"
	elif(p_track_type == TRACK_TYPE_ASYNC_TRACK):
		return "ASYNC_TRACK"
	else:
		""

@export var track_title: String = ""
@export var track_artist: String = ""
@export var track_type: int = TRACK_TYPE_SINGLE_TRACK
@export var contains_loop: bool = false
@export var loop_start: float = 0.0
@export var track_path: String = ""
@export var playable_on_music_player: bool = false
@export var conditionals: Resource = conditionals_const.new()

func _load_record(p_dictionary_record, p_databases):
	# Read Data
	super._load_record(p_dictionary_record, p_databases)
	
	if(p_dictionary_record.has("track_title")):
		track_title = p_dictionary_record.track_title
	if(p_dictionary_record.has("track_artist")):
		track_artist = p_dictionary_record.track_artist
	if(p_dictionary_record.has("track_path")):
		track_path = p_dictionary_record.track_path
	if(p_dictionary_record.has("contains_loop")):
		contains_loop = p_dictionary_record.contains_loop
	if(p_dictionary_record.has("loop_start")):
		loop_start = p_dictionary_record.loop_start
	if(p_dictionary_record.has("playable_on_music_player")):
		playable_on_music_player = p_dictionary_record.playable_on_music_player
	if(p_dictionary_record.has("conditionals")):
		conditionals_const.load_from_dictionary(conditionals, p_dictionary_record.conditionals, p_databases)

func _save_record(p_dictionary_record, p_databases):
	# Write Data
	super._save_record(p_dictionary_record, p_databases)
	
	p_dictionary_record.track_title = track_title
	p_dictionary_record.track_artist = track_artist
	p_dictionary_record.track_path = track_path
	p_dictionary_record.contains_loop = contains_loop
	p_dictionary_record.loop_start = loop_start
	p_dictionary_record.playable_on_music_player = playable_on_music_player
	p_dictionary_record.conditionals = conditionals_const.save_to_dictionary(conditionals, p_databases)
