@tool
extends "./database_panel.gd"

var current_body_scaler_key = ""
var current_stamp = ""

@export var skeleton_male_path: NodePath = NodePath()
@export var skeleton_female_path: NodePath = NodePath()

@export var physics_male_path: NodePath = NodePath()
@export var physics_female_path: NodePath = NodePath()

@export var body_scaler_male_table: NodePath = NodePath()
@export var body_scaler_female_table: NodePath = NodePath()

@export var naked_clothing: NodePath = NodePath()

@export var male_skin_stamp: NodePath = NodePath()
@export var female_skin_stamp: NodePath = NodePath()

@onready var _skeleton_male_path_control = get_node(skeleton_male_path)
@onready var _skeleton_female_path_control = get_node(skeleton_female_path)

@onready var _physics_male_path_control = get_node(physics_male_path)
@onready var _physics_female_path_control = get_node(physics_female_path)

@onready var _body_scaler_male_table_control = get_node(body_scaler_male_table)
@onready var _body_scaler_female_table_control = get_node(body_scaler_female_table)

@onready var _naked_clothing_control = get_node(naked_clothing)

@onready var _male_skin_stamp = get_node(male_skin_stamp)
@onready var _female_skin_stamp = get_node(female_skin_stamp)

func _ready():
	pass

func galatea_databases_assigned():
	super.galatea_databases_assigned()

	current_database = galatea_databases.body_database

	if(current_database != null):
		database_records.populate_tree(current_database, null)

		_body_scaler_male_table_control.assign_database(galatea_databases.body_scaler_database)
		_body_scaler_female_table_control.assign_database(galatea_databases.body_scaler_database)

		_naked_clothing_control.assign_database(galatea_databases.clothing_set_database)

		_male_skin_stamp.assign_database(galatea_databases.stamp_database)
		_female_skin_stamp.assign_database(galatea_databases.stamp_database)

	else:
		printerr("body_databases is null")

func set_current_record_callback(p_record):
	super.set_current_record_callback(p_record)

	var body_scaler_male_records = []
	for record in p_record.body_scaler_male_table:
		if(record):
			body_scaler_male_records.append(record)

	var body_scaler_female_records = []
	for record in p_record.body_scaler_female_table:
		if(record):
			body_scaler_female_records.append(record)

	_body_scaler_male_table_control.set_disabled(false)
	_body_scaler_male_table_control.populate_tree(body_scaler_male_records, null)
	
	_body_scaler_female_table_control.set_disabled(false)
	_body_scaler_female_table_control.populate_tree(body_scaler_female_records, null)
	
	_skeleton_male_path_control.set_disabled(false)
	_skeleton_male_path_control.set_file_path(p_record.skeleton_male_path)

	_skeleton_female_path_control.set_disabled(false)
	_skeleton_female_path_control.set_file_path(p_record.skeleton_female_path)
	
	_physics_male_path_control.set_disabled(false)
	_physics_male_path_control.set_file_path(p_record.physics_male_path)

	_physics_female_path_control.set_disabled(false)
	_physics_female_path_control.set_file_path(p_record.physics_female_path)

	_naked_clothing_control.set_disabled(false)
	if(p_record.naked_clothing_set):
		_naked_clothing_control.set_record_name(p_record.naked_clothing_set.id)
	else:
		_naked_clothing_control.set_record_name("")
		
	_male_skin_stamp.set_disabled(false)
	if(p_record.male_skin_stamp):
		_male_skin_stamp.set_record_name(p_record.male_skin_stamp.id)
	else:
		_male_skin_stamp.set_record_name("")
		
	_female_skin_stamp.set_disabled(false)
	if(p_record.female_skin_stamp):
		_female_skin_stamp.set_record_name(p_record.female_skin_stamp.id)
	else:
		_female_skin_stamp.set_record_name("")

func _on_MaleSkeletonPathControl_file_selected( p_path ):
	if(current_record):
		current_record.skeleton_male_path = p_path
		current_database.mark_database_as_modified(current_database.DATABASE_NAME)

func _on_FemaleSkeletonPathControl_file_selected( p_path ):
	if(current_record):
		current_record.skeleton_female_path = p_path
		current_database.mark_database_as_modified(current_database.DATABASE_NAME)
		
func _on_MalePhysicsPathControl_file_selected( p_path ):
	if(current_record):
		current_record.physics_male_path = p_path
		current_database.mark_database_as_modified(current_database.DATABASE_NAME)
	
func _on_FemalePhysicsPathControl_file_selected( p_path ):
	if(current_record):
		current_record.physics_female_path = p_path
		current_database.mark_database_as_modified(current_database.DATABASE_NAME)
	
func _on_MaleSkinTextureSet_record_selected( p_record ):
	if(current_record):
		current_record.male_skin_stamp = p_record
		current_database.mark_database_as_modified(current_database.DATABASE_NAME)

func _on_MaleSkinTextureSet_record_erased( p_record ):
	if(current_record):
		current_record.male_skin_stamp = p_record
		current_database.mark_database_as_modified(current_database.DATABASE_NAME)

func _on_FemaleSkinTextureSet_record_selected( p_record ):
	if(current_record):
		current_record.female_skin_stamp = p_record
		current_database.mark_database_as_modified(current_database.DATABASE_NAME)

func _on_FemaleSkinTextureSet_record_erased( p_record ):
	if(current_record):
		current_record.female_skin_stamp = p_record
		current_database.mark_database_as_modified(current_database.DATABASE_NAME)

func _on_MaleScalerTableControl_record_cell_selected( p_record ):
	if(current_record):
		current_body_scaler_key = p_record.id
	else:
		current_body_scaler_key = ""

func _on_MaleScalerTableControl_record_erased( p_record ):
	if(current_record):
		if(current_record.body_scaler_male_table.find(p_record) != -1):
			current_record.body_scaler_male_table.erase(p_record)
			
			var body_scaler_records = []
			for record in current_record.body_scaler_male_table:
				if(record):
					body_scaler_records.append(record)
					
			current_body_scaler_key = ""
			
			_body_scaler_male_table_control.populate_tree(body_scaler_records, null)
			current_database.mark_database_as_modified(current_database.DATABASE_NAME)
			
func _on_MaleScalerTableControl_record_selected( p_record ):
	if(current_record and current_record != p_record):
		if(current_record.body_scaler_male_table.find(p_record) != -1):
			return
		else:
			current_record.body_scaler_male_table.append(p_record)
			
			var body_scaler_records = []
			for record in current_record.body_scaler_male_table:
				if(record):
					body_scaler_records.append(record)
					
			current_body_scaler_key = ""
			
			_body_scaler_male_table_control.populate_tree(body_scaler_records, null)
			current_database.mark_database_as_modified(current_database.DATABASE_NAME)

func _on_FemaleScalerTableControl_record_cell_selected( p_record ):
	if(current_record):
		current_body_scaler_key = p_record.id
	else:
		current_body_scaler_key = ""

func _on_FemaleScalerTableControl_record_erased( p_record ):
	if(current_record):
		if(current_record.body_scaler_female_table.find(p_record) != -1):
			current_record.body_scaler_female_table.erase(p_record)
			
			var body_scaler_records = []
			for record in current_record.body_scaler_female_table:
				if(record):
					body_scaler_records.append(record)
					
			current_body_scaler_key = ""
			
			_body_scaler_female_table_control.populate_tree(body_scaler_records, null)
			current_database.mark_database_as_modified(current_database.DATABASE_NAME)
			
func _on_FemaleScalerTableControl_record_selected( p_record ):
	if(current_record and current_record != p_record):
		if(current_record.body_scaler_female_table.find(p_record) != -1):
			return
		else:
			current_record.body_scaler_female_table.append(p_record)
			
			var body_scaler_records = []
			for record in current_record.body_scaler_female_table:
				if(record):
					body_scaler_records.append(record)
					
			current_body_scaler_key = ""
			
			_body_scaler_female_table_control.populate_tree(body_scaler_records, null)
			current_database.mark_database_as_modified(current_database.DATABASE_NAME)

func _on_NakedClothing_record_selected( p_record ):
	if(current_record):
		current_record.naked_clothing_set = p_record
		current_database.mark_database_as_modified(current_database.DATABASE_NAME)
		
func _on_NakedClothing_record_erased( p_record ):
	if(current_record):
		current_record.naked_clothing_set = p_record
		current_database.mark_database_as_modified(current_database.DATABASE_NAME)
