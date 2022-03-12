@tool
const actor_record_const = preload("../databases/actor_record.gd")
const date_and_time_const = preload("res://addons/date_and_time/date_and_time.gd")

const ARGUMENT_TYPE_ENUM = 0
const ARGUMENT_TYPE_BOOL = 2
const ARGUMENT_TYPE_INT = 3
const ARGUMENT_TYPE_FLOAT = 4
const ARGUMENT_TYPE_STRING = 5
const ARGUMENT_TYPE_OBJECT = 6

class ArgumentOption extends Resource:
	@export var option_name: String
	@export var option_value: int = 0
	
	func _init(p_option_name, p_option_value):
		option_name = p_option_name
		option_value = p_option_value

class ArgumentItem extends Resource:
	@export var name: String = ""
	@export var type: int = self.ARGUMENT_TYPE_ENUM
	@export var options: Array = []
	
	func _init(p_name, p_type = self.ARGUMENT_TYPE_ENUM, p_options = []):
		name = p_name
		type = p_type
		options = p_options

class MethodItem extends Resource:
	@export var arguments: Array = []
	@export var category: String = ""
	
	func _init(p_arguments = [], p_category = ""):
		arguments = p_arguments
		category = p_category
	
static func get_master_method_dict():
	var dict = {}
	
	# Install method references
	dict["is_in_actor_group"] = MethodItem.new([ArgumentItem.new("p_actor_group", ARGUMENT_TYPE_STRING)])
	
	dict["has_bloodtype"] = MethodItem.new([ArgumentItem.new("p_bloodtype", ARGUMENT_TYPE_ENUM, {"enums":[
		ArgumentOption.new("A", BloodType.BLOODTYPE_A),
		ArgumentOption.new("B", BloodType.BLOODTYPE_B),
		ArgumentOption.new("AB", BloodType.BLOODTYPE_AB),
		ArgumentOption.new("O", BloodType.BLOODTYPE_O),
		]})])
		
	dict["is_gender"] = MethodItem.new([ArgumentItem.new("p_gender", ARGUMENT_TYPE_ENUM, {"enums":[
		ArgumentOption.new("Male", Gender.GENDER_MALE),
		ArgumentOption.new("Female", Gender.GENDER_FEMALE),
		ArgumentOption.new("Other", Gender.GENDER_OTHER),
		]})])
		
	dict["is_given_name"] = MethodItem.new([ArgumentItem.new("p_given_name", ARGUMENT_TYPE_STRING)])
	dict["is_family_name"] = MethodItem.new([ArgumentItem.new("p_family_name", ARGUMENT_TYPE_STRING)])
	
	dict["get_current_time"] = MethodItem.new()
	dict["get_day_of_the_week"] = MethodItem.new()
	
	dict["is_date_of_birth_day"] = MethodItem.new([ArgumentItem.new("p_day", ARGUMENT_TYPE_INT)])
	dict["is_date_of_birth_month"] = MethodItem.new([ArgumentItem.new("p_month", ARGUMENT_TYPE_ENUM, {"enums":[
		ArgumentOption.new("January", OS.MONTH_JANUARY),
		ArgumentOption.new("February", OS.MONTH_FEBRUARY),
		ArgumentOption.new("March", OS.MONTH_MARCH),
		ArgumentOption.new("April", OS.MONTH_APRIL),
		ArgumentOption.new("May", OS.MONTH_MAY),
		ArgumentOption.new("June", OS.MONTH_JUNE),
		ArgumentOption.new("July", OS.MONTH_JULY),
		ArgumentOption.new("August", OS.MONTH_AUGUST),
		ArgumentOption.new("September", OS.MONTH_SEPTEMBER),
		ArgumentOption.new("October", OS.MONTH_OCTOBER),
		ArgumentOption.new("November", OS.MONTH_NOVEMBER),
		ArgumentOption.new("December", OS.MONTH_DECEMBER),
		]})])
		
	dict["has_calendar_event"] = MethodItem.new([ArgumentItem.new("p_event", ARGUMENT_TYPE_OBJECT, {"database":"calendar_event_database"})])
	dict["is_in_location"] = MethodItem.new([ArgumentItem.new("p_location", ARGUMENT_TYPE_OBJECT, {"database":"location_database"})])
	dict["is_player"] = MethodItem.new([ArgumentItem.new("p_is_player", ARGUMENT_TYPE_BOOL)])

	dict["is_actor_instance_in_location"] = MethodItem.new([
		ArgumentItem.new("p_actor", ARGUMENT_TYPE_OBJECT, {"database":"actor_database"}),
		ArgumentItem.new("p_location", ARGUMENT_TYPE_OBJECT, {"database":"location_database"})])

	dict["get_global_svar"] = MethodItem.new([
		ArgumentItem.new("p_svar", ARGUMENT_TYPE_OBJECT, {"database":"global_svar_database"})])

	dict["is_freeroaming"] = MethodItem.new()

	#dict["get_actor_stat"] = MethodItem.new([
	#	ArgumentItem.new("p_actor", ARGUMENT_TYPE_OBJECT, {"database":"actor_database"})])
		
	return dict
