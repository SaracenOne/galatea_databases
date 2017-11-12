tool
extends "database_panel.gd"

const weather_record_const = preload("res://addons/galatea_databases/databases/weather_record.gd")

const COLOR_TYPE_AMBIENT = 0
const COLOR_TYPE_CLOUDS = 1
const COLOR_TYPE_BEGIN_FOG = 2
const COLOR_TYPE_END_FOG = 3
const COLOR_TYPE_SKY_COLOR = 4
const COLOR_TYPE_SUN_COLOR = 5
const COLOR_TYPE_LIGHT_COLOR = 6

var current_color_type = COLOR_TYPE_AMBIENT
var current_layer_number = 0

export(NodePath) var color_type_menu = NodePath()

export(NodePath) var sunrise_color_picker_button = NodePath()
export(NodePath) var day_color_picker_button = NodePath()
export(NodePath) var sunset_color_picker_button = NodePath()
export(NodePath) var night_color_picker_button = NodePath()

export(NodePath) var layer_number_menu = NodePath()
export(NodePath) var layer_texture_path = NodePath()
export(NodePath) var layer_texture_preview = NodePath()
export(NodePath) var layer_scroll_x = NodePath()
export(NodePath) var layer_scroll_y = NodePath()
export(NodePath) var layer_scroll_alpha = NodePath()

export(NodePath) var precipitation_control = NodePath()

export(NodePath) var wind_power = NodePath()
export(NodePath) var wind_direction = NodePath()
export(NodePath) var wind_variation = NodePath()

onready var _color_type_menu = get_node(color_type_menu)

onready var _sunrise_color_picker_button = get_node(sunrise_color_picker_button)
onready var _day_color_picker_button = get_node(day_color_picker_button)
onready var _sunset_color_picker_button = get_node(sunset_color_picker_button)
onready var _night_color_picker_button = get_node(night_color_picker_button)

onready var _layer_number_menu = get_node(layer_number_menu)
onready var _layer_texture_path = get_node(layer_texture_path)
onready var _layer_texture_preview = get_node(layer_texture_preview)
onready var _layer_scroll_x = get_node(layer_scroll_x)
onready var _layer_scroll_y = get_node(layer_scroll_y)
onready var _layer_scroll_alpha = get_node(layer_scroll_alpha)

onready var _precipitation_control = get_node(precipitation_control)

onready var _wind_power = get_node(wind_power)
onready var _wind_direction = get_node(wind_direction)
onready var _wind_variation = get_node(wind_variation)

func _ready():
	_color_type_menu.get_popup().connect("item_pressed", self, "_color_type_selected")
	_layer_number_menu.get_popup().connect("item_pressed", self, "_layer_number_selected")

func galatea_databases_assigned():
	.galatea_databases_assigned()
	
	current_database = galatea_databases.weather_database
	if(current_database != null):
		database_records.populate_tree(current_database, null)
		_precipitation_control.assign_database(galatea_databases.precipitation_database)
	else:
		printerr("weather_database is null")

func set_current_record_callback(p_record):
	.set_current_record_callback(p_record)
	
	_color_type_menu.set_disabled(false)

	_sunrise_color_picker_button.set_disabled(false)
	_sunrise_color_picker_button.set_edit_alpha(true)
	_day_color_picker_button.set_disabled(false)
	_day_color_picker_button.set_edit_alpha(true)
	_sunset_color_picker_button.set_disabled(false)
	_sunset_color_picker_button.set_edit_alpha(true)
	_night_color_picker_button.set_disabled(false)
	_night_color_picker_button.set_edit_alpha(true)
	
	_layer_number_menu.set_disabled(false)
	_layer_texture_path.set_disabled(false)
	_layer_scroll_x.set_editable(true)
	_layer_scroll_x.set_step(0.001)
	_layer_scroll_y.set_editable(true)
	_layer_scroll_y.set_step(0.001)
	_layer_scroll_alpha.set_editable(true)
	_layer_scroll_alpha.set_step(0.001)

	if(p_record.precipitation):
		_precipitation_control.set_record_name(p_record.precipitation.id)
	else:
		_precipitation_control.set_record_name("")
	_precipitation_control.set_disabled(false)
	
	set_color_selectors_to_record_colors(current_color_type)
	set_layer_info_to_layer_number(current_layer_number)
	
	_wind_power.set_editable(true)
	_wind_power.set_step(0.001)
	_wind_power.set_value(current_record.wind_power)
	
	_wind_direction.set_editable(true)
	_wind_direction.set_step(1)
	_wind_direction.set_value(current_record.wind_direction)
	
	_wind_variation.set_editable(true)
	_wind_variation.set_step(1)
	_wind_variation.set_value(current_record.wind_variation)

func set_color_selectors_to_record_colors(p_color_type):
	if(current_record):
		if(current_color_type == COLOR_TYPE_AMBIENT):
			_sunrise_color_picker_button.set_color(current_record.color_sets[weather_record_const.TIME_SUNRISE].ambient_color)
			_day_color_picker_button.set_color(current_record.color_sets[weather_record_const.TIME_DAY].ambient_color)
			_sunset_color_picker_button.set_color(current_record.color_sets[weather_record_const.TIME_SUNSET].ambient_color)
			_night_color_picker_button.set_color(current_record.color_sets[weather_record_const.TIME_NIGHT].ambient_color)
		elif(current_color_type == COLOR_TYPE_CLOUDS):
			_sunrise_color_picker_button.set_color(current_record.color_sets[weather_record_const.TIME_SUNRISE].clouds_color)
			_day_color_picker_button.set_color(current_record.color_sets[weather_record_const.TIME_DAY].clouds_color)
			_sunset_color_picker_button.set_color(current_record.color_sets[weather_record_const.TIME_SUNSET].clouds_color)
			_night_color_picker_button.set_color(current_record.color_sets[weather_record_const.TIME_NIGHT].clouds_color)
		elif(current_color_type == COLOR_TYPE_BEGIN_FOG):
			_sunrise_color_picker_button.set_color(current_record.color_sets[weather_record_const.TIME_SUNRISE].begin_fog_color)
			_day_color_picker_button.set_color(current_record.color_sets[weather_record_const.TIME_DAY].begin_fog_color)
			_sunset_color_picker_button.set_color(current_record.color_sets[weather_record_const.TIME_SUNSET].begin_fog_color)
			_night_color_picker_button.set_color(current_record.color_sets[weather_record_const.TIME_NIGHT].begin_fog_color)
		elif(current_color_type == COLOR_TYPE_END_FOG):
			_sunrise_color_picker_button.set_color(current_record.color_sets[weather_record_const.TIME_SUNRISE].end_fog_color)
			_day_color_picker_button.set_color(current_record.color_sets[weather_record_const.TIME_DAY].end_fog_color)
			_sunset_color_picker_button.set_color(current_record.color_sets[weather_record_const.TIME_SUNSET].end_fog_color)
			_night_color_picker_button.set_color(current_record.color_sets[weather_record_const.TIME_NIGHT].end_fog_color)
		elif(current_color_type == COLOR_TYPE_SKY_COLOR):
			_sunrise_color_picker_button.set_color(current_record.color_sets[weather_record_const.TIME_SUNRISE].sky_color)
			_day_color_picker_button.set_color(current_record.color_sets[weather_record_const.TIME_DAY].sky_color)
			_sunset_color_picker_button.set_color(current_record.color_sets[weather_record_const.TIME_SUNSET].sky_color)
			_night_color_picker_button.set_color(current_record.color_sets[weather_record_const.TIME_NIGHT].sky_color)
		elif(current_color_type == COLOR_TYPE_SUN_COLOR):
			_sunrise_color_picker_button.set_color(current_record.color_sets[weather_record_const.TIME_SUNRISE].sun_color)
			_day_color_picker_button.set_color(current_record.color_sets[weather_record_const.TIME_DAY].sun_color)
			_sunset_color_picker_button.set_color(current_record.color_sets[weather_record_const.TIME_SUNSET].sun_color)
			_night_color_picker_button.set_color(current_record.color_sets[weather_record_const.TIME_NIGHT].sun_color)
		elif(current_color_type == COLOR_TYPE_LIGHT_COLOR):
			_sunrise_color_picker_button.set_color(current_record.color_sets[weather_record_const.TIME_SUNRISE].light_color)
			_day_color_picker_button.set_color(current_record.color_sets[weather_record_const.TIME_DAY].light_color)
			_sunset_color_picker_button.set_color(current_record.color_sets[weather_record_const.TIME_SUNSET].light_color)
			_night_color_picker_button.set_color(current_record.color_sets[weather_record_const.TIME_NIGHT].light_color)

func set_layer_info_to_layer_number(p_layer_number):
	if(current_record):
		var cloud_path = current_record.cloud_layers[p_layer_number].cloud_path
		
		_layer_texture_path.set_file_path(cloud_path)
		
		_layer_texture_preview.set_texture(null)
		var cloud_texture = null
		if(!cloud_path.empty()):
			cloud_texture = load(cloud_path)
		if(cloud_texture and cloud_path):
			if(cloud_texture is Texture):
				_layer_texture_preview.set_texture(cloud_texture)
		
		_layer_scroll_x.set_value(current_record.cloud_layers[p_layer_number].scroll_x)
		_layer_scroll_y.set_value(current_record.cloud_layers[p_layer_number].scroll_y)
		_layer_scroll_alpha.set_value(current_record.cloud_layers[p_layer_number].alpha)

func _on_SunriseColorPickerButton_color_changed( color ):
	if(current_record):
		if(current_color_type == COLOR_TYPE_AMBIENT):
			current_record.color_sets[weather_record_const.TIME_SUNRISE].ambient_color = color
		elif(current_color_type == COLOR_TYPE_CLOUDS):
			current_record.color_sets[weather_record_const.TIME_SUNRISE].clouds_color = color
		elif(current_color_type == COLOR_TYPE_BEGIN_FOG):
			current_record.color_sets[weather_record_const.TIME_SUNRISE].begin_fog_color = color
		elif(current_color_type == COLOR_TYPE_END_FOG):
			current_record.color_sets[weather_record_const.TIME_SUNRISE].end_fog_color = color
		elif(current_color_type == COLOR_TYPE_SKY_COLOR):
			current_record.color_sets[weather_record_const.TIME_SUNRISE].sky_color = color
		elif(current_color_type == COLOR_TYPE_SUN_COLOR):
			current_record.color_sets[weather_record_const.TIME_SUNRISE].sun_color = color
		elif(current_color_type == COLOR_TYPE_LIGHT_COLOR):
			current_record.color_sets[weather_record_const.TIME_SUNRISE].light_color = color
		
	current_database.mark_database_as_modified()


func _on_DayColorPickerButton_color_changed( color ):
	if(current_record):
		if(current_color_type == COLOR_TYPE_AMBIENT):
			current_record.color_sets[weather_record_const.TIME_DAY].ambient_color = color
		elif(current_color_type == COLOR_TYPE_CLOUDS):
			current_record.color_sets[weather_record_const.TIME_DAY].clouds_color = color
		elif(current_color_type == COLOR_TYPE_BEGIN_FOG):
			current_record.color_sets[weather_record_const.TIME_DAY].begin_fog_color = color
		elif(current_color_type == COLOR_TYPE_END_FOG):
			current_record.color_sets[weather_record_const.TIME_DAY].end_fog_color = color
		elif(current_color_type == COLOR_TYPE_SKY_COLOR):
			current_record.color_sets[weather_record_const.TIME_DAY].sky_color = color
		elif(current_color_type == COLOR_TYPE_SUN_COLOR):
			current_record.color_sets[weather_record_const.TIME_DAY].sun_color = color
		elif(current_color_type == COLOR_TYPE_LIGHT_COLOR):
			current_record.color_sets[weather_record_const.TIME_DAY].light_color = color
		
	current_database.mark_database_as_modified()


func _on_SunsetColorPickerButton_color_changed( color ):
	if(current_record):
		if(current_color_type == COLOR_TYPE_AMBIENT):
			current_record.color_sets[weather_record_const.TIME_SUNSET].ambient_color = color
		elif(current_color_type == COLOR_TYPE_CLOUDS):
			current_record.color_sets[weather_record_const.TIME_SUNSET].clouds_color = color
		elif(current_color_type == COLOR_TYPE_BEGIN_FOG):
			current_record.color_sets[weather_record_const.TIME_SUNSET].begin_fog_color = color
		elif(current_color_type == COLOR_TYPE_END_FOG):
			current_record.color_sets[weather_record_const.TIME_SUNSET].end_fog_color = color
		elif(current_color_type == COLOR_TYPE_SKY_COLOR):
			current_record.color_sets[weather_record_const.TIME_SUNSET].sky_color = color
		elif(current_color_type == COLOR_TYPE_SUN_COLOR):
			current_record.color_sets[weather_record_const.TIME_SUNSET].sun_color = color
		elif(current_color_type == COLOR_TYPE_LIGHT_COLOR):
			current_record.color_sets[weather_record_const.TIME_SUNSET].light_color = color
		
	current_database.mark_database_as_modified()


func _on_NightColorPickerButton_color_changed( color ):
	if(current_record):
		if(current_color_type == COLOR_TYPE_AMBIENT):
			current_record.color_sets[weather_record_const.TIME_NIGHT].ambient_color = color
		elif(current_color_type == COLOR_TYPE_CLOUDS):
			current_record.color_sets[weather_record_const.TIME_NIGHT].clouds_color = color
		elif(current_color_type == COLOR_TYPE_BEGIN_FOG):
			current_record.color_sets[weather_record_const.TIME_NIGHT].begin_fog_color = color
		elif(current_color_type == COLOR_TYPE_END_FOG):
			current_record.color_sets[weather_record_const.TIME_NIGHT].end_fog_color = color
		elif(current_color_type == COLOR_TYPE_SKY_COLOR):
			current_record.color_sets[weather_record_const.TIME_NIGHT].sky_color = color
		elif(current_color_type == COLOR_TYPE_SUN_COLOR):
			current_record.color_sets[weather_record_const.TIME_NIGHT].sun_color = color
		elif(current_color_type == COLOR_TYPE_LIGHT_COLOR):
			current_record.color_sets[weather_record_const.TIME_NIGHT].light_color = color
		
	current_database.mark_database_as_modified()

func _on_TextureFilePathControl_file_selected( p_path ):
	if(current_record):
		current_record.cloud_layers[current_layer_number].cloud_path = p_path
		current_database.mark_database_as_modified()
		
		_layer_texture_preview.set_texture(null)
		var cloud_texture = null
		if(!p_path.empty()):
			cloud_texture = load(p_path)
		if(p_path):
			if(cloud_texture is Texture):
				_layer_texture_preview.set_texture(cloud_texture)


func _on_ScrollSpeedXSpinBox_value_changed( value ):
	if(current_record):
		current_record.cloud_layers[current_layer_number].scroll_x = value
		current_database.mark_database_as_modified()


func _on_ScrollSpeedYSpinBox_value_changed( value ):
	if(current_record):
		current_record.cloud_layers[current_layer_number].scroll_y = value
		current_database.mark_database_as_modified()


func _on_AlphaSpinBox_value_changed( value ):
	if(current_record):
		current_record.cloud_layers[current_layer_number].alpha = value
		current_database.mark_database_as_modified()


func _on_PrecipitationRecordsReference_record_selected( p_record ):
	if(current_record):
		current_record.precipitation = p_record
		current_database.mark_database_as_modified()


func _on_PrecipitationRecordsReference_record_erased( p_record ):
	if(current_record):
		current_record.precipitation = null
		current_database.mark_database_as_modified()

func _on_WindPowerSpinBox_value_changed( value ):
	if(current_record):
		current_record.wind_power = value
		current_database.mark_database_as_modified()


func _on_WindDirectionSpinBox_value_changed( value ):
	if(current_record):
		current_record.wind_direction = value
		current_database.mark_database_as_modified()


func _on_WindVariationSpinBox_value_changed( value ):
	if(current_record):
		current_record.wind_variation = value
		current_database.mark_database_as_modified()
	
func _color_type_selected(p_id):
	_color_type_menu.set_text(_color_type_menu.get_popup().get_item_text(p_id))
	current_color_type = p_id
	set_color_selectors_to_record_colors(current_color_type)
	
func _layer_number_selected(p_id):
	_layer_number_menu.set_text(_layer_number_menu.get_popup().get_item_text(p_id))
	current_layer_number = p_id
	set_layer_info_to_layer_number(current_layer_number)