const ARGUMENT_TYPE_ENUM = 0

class ArgumentOption extends Reference:
	var option_name
	var option_value
	
	func _init(p_option_name, p_option_value):
		option_name = p_option_name
		option_value = p_option_value

class ArgumentItem extends Reference:
	var name
	var type
	var options
	
	func _init(p_name, p_type = ARGUMENT_TYPE_ENUM, p_options = []):
		name = p_name
		type = p_type
		options = p_options

class MethodItem extends Reference:
	var arguments = []
	var category = ""
	
	func _init(p_arguments = [], p_category = ""):
		arguments = p_arguments
		category = p_category
	
static func get_master_method_dict():
	var dict = {}
	dict["test_method"] = MethodItem.new(ArgumentItem.new("test_arg_1", ARGUMENT_TYPE_ENUM, [
		ArgumentOption.new("1", 1),
		ArgumentOption.new("2", 2),
		ArgumentOption.new("3", 3),
		]))
		
	return dict