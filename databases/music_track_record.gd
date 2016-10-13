extends "generic_record.gd"

const conditionals_const = preload("../conditionals/conditionals.gd")

const TRACK_TYPE_SINGLE_TRACK = 0
const TRACK_TYPE_ASYNC_TRACK = 1

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

var track_title = ""
var track_artist = ""
var track_type = TRACK_TYPE_SINGLE_TRACK
var contains_loop = false
var loop_start = 0.0
var track_path = ""
var playable_on_music_player = false
var conditionals = conditionals_const.new()

func _load_record(p_dictionary_record, p_databases):
	# Read Data
	._load_record(p_dictionary_record, p_databases)
	
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
	._save_record(p_dictionary_record, p_databases)
	
	p_dictionary_record.track_title = track_title
	p_dictionary_record.track_artist = track_artist
	p_dictionary_record.track_path = track_path
	p_dictionary_record.contains_loop = contains_loop
	p_dictionary_record.loop_start = loop_start
	p_dictionary_record.playable_on_music_player = playable_on_music_player
	p_dictionary_record.conditionals = conditionals_const.save_to_dictionary(conditionals, p_databases)