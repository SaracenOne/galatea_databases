@tool
extends "./database_panel.gd"

@export var texture_path: NodePath  = NodePath()
@export var texture_path_texture: NodePath  = NodePath()
@export var shader_path: NodePath  = NodePath()
@export var sub_texture_count_xy: NodePath  = NodePath()
@export var box_size: NodePath  = NodePath()
@export var wind_multiplier: NodePath  = NodePath()
@export var particle_density: NodePath  = NodePath()
@export var particle_rotation_velocity: NodePath  = NodePath()
@export var particle_size_x: NodePath  = NodePath()
@export var particle_size_y: NodePath  = NodePath()

@onready var _texture_path_control = get_node(texture_path)
@onready var _texture_path_texture_control = get_node(texture_path_texture)
@onready var _shader_path_control = get_node(shader_path)
@onready var _sub_texture_count_xy_control = get_node(sub_texture_count_xy)
@onready var _box_size_control = get_node(box_size)
@onready var _wind_multiplier_control = get_node(wind_multiplier)
@onready var _particle_density_control = get_node(particle_density)
@onready var _particle_rotation_velocity_control = get_node(particle_rotation_velocity)
@onready var _particle_size_x_control = get_node(particle_size_x)
@onready var _particle_size_y_control = get_node(particle_size_y)

func _ready():
	pass
	
func galatea_databases_assigned():
	super.galatea_databases_assigned()
	
	current_database = galatea_databases.precipitation_database
	
	if(current_database != null):
		database_records.populate_tree(current_database, null)
	else:
		printerr("precipitation_databases is null")

func set_current_record_callback(p_record):
	super.set_current_record_callback(p_record)
	
	_texture_path_control.set_disabled(false)
	_texture_path_control.set_file_path(p_record.texture_path)
	_texture_path_texture_control.set_texture(null)
	var particle_texture = null
	if(!p_record.texture_path.is_empty()):
		particle_texture = load(p_record.texture_path)
	if(particle_texture):
		if(particle_texture is Texture):
			_texture_path_texture_control.set_texture(particle_texture)
			
	_shader_path_control.set_disabled(false)
	_shader_path_control.set_file_path(p_record.shader_path)
			
	_sub_texture_count_xy_control.set_editable(true)
	_sub_texture_count_xy_control.set_value(p_record.sub_texture_count_xy)
	_sub_texture_count_xy_control.set_step(1)
	
	_box_size_control.set_editable(true)
	_box_size_control.set_value(p_record.box_size)
	_box_size_control.set_step(0.0001)
	
	_wind_multiplier_control.set_editable(true)
	_wind_multiplier_control.set_value(p_record.wind_multiplier)
	_wind_multiplier_control.set_step(0.000001)
	
	_particle_density_control.set_editable(true)
	_particle_density_control.set_value(p_record.particle_density)
	_particle_density_control.set_step(0.000001)
	
	_particle_rotation_velocity_control.set_editable(true)
	_particle_rotation_velocity_control.set_value(p_record.particle_rotation_velocity)
	_particle_rotation_velocity_control.set_step(0.000001)
	
	_particle_size_x_control.set_editable(true)
	_particle_size_x_control.set_value(p_record.particle_size.x)
	_particle_size_x_control.set_step(0.000001)
	
	_particle_size_y_control.set_editable(true)
	_particle_size_y_control.set_value(p_record.particle_size.y)
	_particle_size_y_control.set_step(0.000001)

func _on_TexturePathControl_file_selected(p_path: String):
	if(current_record):
		current_record.texture_path = p_path
		current_database.mark_database_as_modified(current_database.DATABASE_NAME)
		
		var particle_texture = null
		if(!current_record.texture_path.is_empty()):
			particle_texture = load(current_record.texture_path)
		if(particle_texture):
			if(particle_texture is Texture):
				_texture_path_texture_control.set_texture(particle_texture)
		
func _on_ShaderPathControl_file_selected( p_path ):
	if(current_record):
		current_record.shader_path = p_path
		current_database.mark_database_as_modified(current_database.DATABASE_NAME)
		
func _on_SubTextureCountXYControl_value_changed( value ):
	if(current_record):
		current_record.sub_texture_count_xy = value
		current_database.mark_database_as_modified(current_database.DATABASE_NAME)
		
func _on_BoxSizeControl_value_changed( value ):
	if(current_record):
		current_record.box_size = value
		current_database.mark_database_as_modified(current_database.DATABASE_NAME)
		
func _on_WindMultiplierControl_value_changed( value ):
	if(current_record):
		current_record.wind_multiplier = value
		current_database.mark_database_as_modified(current_database.DATABASE_NAME)
		
func _on_ParticleDensityControl_value_changed( value ):
	if(current_record):
		current_record.particle_density = value
		current_database.mark_database_as_modified(current_database.DATABASE_NAME)
		
func _on_ParticleRotationVelocityControl_value_changed( value ):
	if(current_record):
		current_record.particle_rotation_velocity = value
		current_database.mark_database_as_modified(current_database.DATABASE_NAME)
		
func _on_ParticleSizeControlX_value_changed( value ):
	if(current_record):
		current_record.particle_size.x = value
		current_database.mark_database_as_modified(current_database.DATABASE_NAME)
		
func _on_ParticleSizeControlY_value_changed( value ):
	if(current_record):
		current_record.particle_size.y = value
		current_database.mark_database_as_modified(current_database.DATABASE_NAME)
