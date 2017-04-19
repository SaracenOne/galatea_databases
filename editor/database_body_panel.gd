tool
extends "database_panel.gd"

var current_body_scaler_key = ""
var current_stamp = ""

export(NodePath) var skeleton_male_path = NodePath()
export(NodePath) var skeleton_female_path = NodePath()

export(NodePath) var body_scaler_male_table = NodePath()
export(NodePath) var body_scaler_female_table = NodePath()

export(NodePath) var naked_clothing = NodePath()

export(NodePath) var male_skin_texture_set = NodePath()
export(NodePath) var female_skin_texture_set = NodePath()

onready var _skeleton_male_path_control = get_node(skeleton_male_path)
onready var _skeleton_female_path_control = get_node(skeleton_female_path)

onready var _body_scaler_male_table_control = get_node(body_scaler_male_table)
onready var _body_scaler_female_table_control = get_node(body_scaler_female_table)

onready var _naked_clothing_control = get_node(naked_clothing)

onready var _male_skin_texture_set = get_node(male_skin_texture_set)
onready var _female_skin_texture_set = get_node(female_skin_texture_set)

func _ready():
	pass

func galatea_databases_assigned():
	.galatea_databases_assigned()

	current_database = galatea_databases.body_database

	if(current_database != null):
		database_records.populate_tree(current_database, null)

		_body_scaler_male_table_control.assign_database(galatea_databases.body_scaler_database)
		_body_scaler_female_table_control.assign_database(galatea_databases.body_scaler_database)

		_naked_clothing_control.assign_database(galatea_databases.clothing_database)

		_male_skin_texture_set.assign_database(galatea_databases.texture_set_database)
		_female_skin_texture_set.assign_database(galatea_databases.texture_set_database)

	else:
		printerr("body_databases is null")

func set_current_record_callback(p_record):
	.set_current_record_callback(p_record)

	var body_scaler_male_records = []
	for body_scaler_key in p_record.body_scaler_male_table:
		var record = galatea_databases.body_scaler_database.find_record_by_name(body_scaler_key)
		if(record):
			body_scaler_male_records.append(galatea_databases.body_scaler_database.find_record_by_name(body_scaler_key))

	var body_scaler_female_records = []
	for body_scaler_key in p_record.body_scaler_female_table:
		var record = galatea_databases.body_scaler_database.find_record_by_name(body_scaler_key)
		if(record):
			body_scaler_female_records.append(galatea_databases.body_scaler_database.find_record_by_name(body_scaler_key))

	_body_scaler_male_table_control.set_disabled(false)
	_body_scaler_male_table_control.populate_tree(body_scaler_male_records, null)
	
	_body_scaler_female_table_control.set_disabled(false)
	_body_scaler_female_table_control.populate_tree(body_scaler_female_records, null)
	
	_skeleton_male_path_control.set_disabled(false)
	_skeleton_male_path_control.set_file_path(p_record.skeleton_male_path)

	_skeleton_female_path_control.set_disabled(false)
	_skeleton_female_path_control.set_file_path(p_record.skeleton_female_path)

	_naked_clothing_control.set_disabled(false)
	if(p_record.naked_clothing):
		_naked_clothing_control.set_record_name(p_record.naked_clothing.id)
	else:
		_naked_clothing_control.set_record_name("")
		
	_male_skin_texture_set.set_disabled(false)
	if(p_record.male_skin_texture_set):
		_male_skin_texture_set.set_record_name(p_record.male_skin_texture_set.id)
	else:
		_male_skin_texture_set.set_record_name("")
		
	_female_skin_texture_set.set_disabled(false)
	if(p_record.female_skin_texture_set):
		_female_skin_texture_set.set_record_name(p_record.female_skin_texture_set.id)
	else:
		_female_skin_texture_set.set_record_name("")

func _on_MaleSkeletonPathControl_file_selected( p_path ):
	if(current_record):
		current_record.skeleton_male_path = p_path
		current_database.mark_database_as_modified()

func _on_FemaleSkeletonPathControl_file_selected( p_path ):
	if(current_record):
		current_record.skeleton_female_path = p_path
		current_database.mark_database_as_modified()

func _on_MaleSkinTextureSet_record_selected( p_record ):
	if(current_record):
		current_record.male_skin_texture_set = p_record
		current_database.mark_database_as_modified()

func _on_MaleSkinTextureSet_record_erased( p_record ):
	if(current_record):
		current_record.male_skin_texture_set = p_record
		current_database.mark_database_as_modified()

func _on_FemaleSkinTextureSet_record_selected( p_record ):
	if(current_record):
		current_record.female_skin_texture_set = p_record
		current_database.mark_database_as_modified()

func _on_FemaleSkinTextureSet_record_erased( p_record ):
	if(current_record):
		current_record.female_skin_texture_set = p_record
		current_database.mark_database_as_modified()

func _on_MaleScalerTableControl_record_cell_selected( p_record ):
	if(current_record):
		current_body_scaler_key = p_record.id
	else:
		current_body_scaler_key = ""

func _on_MaleScalerTableControl_record_erased( p_record ):
	if(current_record):
		if(current_record.body_scaler_male_table.find(p_record.id) != -1):
			current_record.body_scaler_male_table.remove(p_record.id)
			
			var body_scaler_records = []
			for body_scaler_key in current_record.body_scaler_male_table:
				var record = galatea_databases.body_scaler_database.find_record_by_name(body_scaler_key)
				if(record):
					body_scaler_records.append(galatea_databases.body_scaler_database.find_record_by_name(body_scaler_key))
					
			current_body_scaler_key = ""
			
			_body_scaler_male_table_control.populate_tree(body_scaler_records, null)
			current_database.mark_database_as_modified()
			
func _on_MaleScalerTableControl_record_selected( p_record ):
	if(current_record and current_record != p_record):
		if(current_record.body_scaler_male_table.find(p_record.id) != -1):
			return
		else:
			current_record.body_scaler_male_table.append(p_record.id)
			
			var body_scaler_records = []
			for body_scaler_key in current_record.body_scaler_male_table:
				var record = galatea_databases.body_scaler_database.find_record_by_name(body_scaler_key)
				if(record):
					body_scaler_records.append(galatea_databases.body_scaler_database.find_record_by_name(body_scaler_key))
					
			current_body_scaler_key = ""
			
			_body_scaler_male_table_control.populate_tree(body_scaler_records, null)
			current_database.mark_database_as_modified()

func _on_FemaleScalerTableControl_record_cell_selected( p_record ):
	if(current_record):
		current_body_scaler_key = p_record.id
	else:
		current_body_scaler_key = ""

func _on_FemaleScalerTableControl_record_erased( p_record ):
	if(current_record):
		if(current_record.body_scaler_female_table.find(p_record.id) != -1):
			current_record.body_scaler_female_table.remove(p_record.id)
			
			var body_scaler_records = []
			for body_scaler_key in current_record.body_scaler_female_table:
				var record = galatea_databases.body_scaler_database.find_record_by_name(body_scaler_key)
				if(record):
					body_scaler_records.append(galatea_databases.body_scaler_database.find_record_by_name(body_scaler_key))
					
			current_body_scaler_key = ""
			
			_body_scaler_female_table_control.populate_tree(body_scaler_records, null)
			current_database.mark_database_as_modified()
			
func _on_FemaleScalerTableControl_record_selected( p_record ):
	if(current_record and current_record != p_record):
		if(current_record.body_scaler_female_table.find(p_record.id) != -1):
			return
		else:
			current_record.body_scaler_female_table.append(p_record.id)
			
			var body_scaler_records = []
			for body_scaler_key in current_record.body_scaler_female_table:
				var record = galatea_databases.body_scaler_database.find_record_by_name(body_scaler_key)
				if(record):
					body_scaler_records.append(galatea_databases.body_scaler_database.find_record_by_name(body_scaler_key))
					
			current_body_scaler_key = ""
			
			_body_scaler_female_table_control.populate_tree(body_scaler_records, null)
			current_database.mark_database_as_modified()

func _on_NakedClothing_record_selected( p_record ):
	if(current_record):
		current_record.naked_clothing = p_record
		current_database.mark_database_as_modified()
		
func _on_NakedClothing_record_erased( p_record ):
	if(current_record):
		current_record.naked_clothing = p_record
		current_database.mark_database_as_modified()
