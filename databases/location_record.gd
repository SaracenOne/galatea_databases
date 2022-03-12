@tool
extends "./generic_record.gd"

const date_and_time_const = preload("res://addons/date_and_time/date_and_time.gd")

@export var printed_name: String = ""
@export var scene_path: String = ""
@export var skybox_path: String = ""
@export var is_interior: bool = false

@export var maximum_actor_capacity: int = -1
@export var maximum_actor_capacity_includes_players: bool = false

class LinkedLocationData extends Resource:
	@export var location: Resource = null
	@export var distance: float = 0.0

@export var linked_locations: Array = []

func _load_record(p_dictionary_record, p_databases):
	# Read Data
	super._load_record(p_dictionary_record, p_databases)
	
	if(p_dictionary_record.has("printed_name")):
		printed_name = p_dictionary_record.printed_name
		
	if(p_dictionary_record.has("scene_path")):
		scene_path = p_dictionary_record.scene_path
		
	if(p_dictionary_record.has("skybox_path")):
		skybox_path = p_dictionary_record.skybox_path
		
	if(p_dictionary_record.has("is_interior")):
		is_interior = p_dictionary_record.is_interior
	
	if(p_dictionary_record.has("maximum_actor_capacity")):
		maximum_actor_capacity = p_dictionary_record.maximum_actor_capacity
	if(p_dictionary_record.has("maximum_actor_capacity_includes_players")):
		maximum_actor_capacity_includes_players = p_dictionary_record.maximum_actor_capacity_includes_players
		
func _save_record(p_dictionary_record, p_databases):
	# Write Data
	super._save_record(p_dictionary_record, p_databases)
	
	p_dictionary_record.printed_name = printed_name
	p_dictionary_record.scene_path = scene_path
	p_dictionary_record.skybox_path = skybox_path
	p_dictionary_record.is_interior = is_interior
	p_dictionary_record.maximum_actor_capacity = maximum_actor_capacity
	p_dictionary_record.maximum_actor_capacity_includes_players = maximum_actor_capacity_includes_players
