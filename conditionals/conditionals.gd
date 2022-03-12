@tool
extends Resource

const methods_const = preload("../methods/methods.gd")

const COMPARISON_OPERATOR_EQUALS = 0
const COMPARISON_OPERATOR_NOT = 1
const COMPARISON_OPERATOR_GREATER = 2
const COMPARISON_OPERATOR_LESSER = 3
const COMPARSION_OPERATOR_EQUALS_OR_GREATER = 4
const COMPARISON_OPERATOR_EQUALS_OR_LESSER = 5

const CONDITIONAL_SUBJECT_SELF = 0
const CONDITIONAL_SUBJECT_TARGET = 1
const CONDITIONAL_SUBJECT_REFERENCE = 2
const CONDITIONAL_SUBJECT_GLOBAL = 3

const VALUE_TYPE_FLOAT = 0
const VALUE_TYPE_STRING = 1
const VALUE_TYPE_SVAR = 2
const VALUE_TYPE_BOOLEAN = 3

class ConditionalItem extends Resource:
	@export var conditional_method = ""
	@export var arguments: Array = []
	@export var operator: int = self.COMPARISON_OPERATOR_EQUALS
	@export var value = 1.0
	@export var value_type: int = self.VALUE_TYPE_FLOAT
	@export var subject: int = self.CONDITIONAL_SUBJECT_SELF
	@export var use_or: bool = false
	
	func copy(p_conditional_item):
		conditional_method = p_conditional_item.conditional_method
		arguments = p_conditional_item.arguments
		operator = p_conditional_item.operator
		value = p_conditional_item.value
		value_type = p_conditional_item.value_type
		subject = p_conditional_item.subject
		use_or = p_conditional_item.use_or
	
@export var conditional_items: Array = []
	
func compare_vars(p_lvar, p_rvar, p_comparison_operator):
	if(p_comparison_operator == COMPARISON_OPERATOR_EQUALS):
		return p_lvar == p_rvar
	elif(p_comparison_operator == COMPARISON_OPERATOR_NOT):
		return p_lvar != p_rvar
	elif(p_comparison_operator == COMPARISON_OPERATOR_GREATER):
		return p_lvar > p_rvar
	elif(p_comparison_operator == COMPARISON_OPERATOR_LESSER):
		return p_lvar < p_rvar
	elif(p_comparison_operator == COMPARSION_OPERATOR_EQUALS_OR_GREATER):
		return p_lvar >= p_rvar
	elif(p_comparison_operator == COMPARISON_OPERATOR_EQUALS_OR_LESSER):
		return p_lvar <= p_rvar
		
func run_conditional_items_for_subject(p_subject, p_global_svar_table):
	if(p_subject):
		for i in range(0, conditional_items.size()):
			var conditional = conditional_items[i]
			
			# Find the valid target
			var l_var = null
			var target = null
			if(conditional.subject == CONDITIONAL_SUBJECT_SELF):
				target = p_subject
			elif(conditional.subject == CONDITIONAL_SUBJECT_TARGET):
				if(p_subject.has_method("get_target")):
					target = p_subject.call("get_target")
					
			var result = false
			if(target):
				# Target found, so now search for conditional method
				if(target.has_method(conditional.conditional_method)):
					l_var = target.callv(conditional.conditional_method, conditional.arguments)
					if(conditional.value_type == VALUE_TYPE_SVAR):
						if(typeof(conditional.value) == TYPE_STRING):
							if(p_global_svar_table.has_svar(conditional.value)):
								var svar = p_global_svar_table.get_svar(conditional.value)
								result = compare_vars(l_var, conditional.operator, svar)
							else:
								printerr("Svar '" + conditional.value + "' does not exist!")
						else:
							printerr("Conditional svar value is not a string!")
					else:
						result = compare_vars(l_var, conditional.operator, conditional.value)
				else:
					printerr("Target '" + target.get_name() + "' has no method '" + conditional.conditional_method + "'!")
				
				if(result == false):
					if(conditional.use_or == false):
						return false
					else:
						if(conditional_items.size() <= i): # No further conditional items to compare so abort
							return false
				else:
					if(conditional.use_or == true):
						return true
	else:
		printerr("p_subject is NULL!")
		
static func string_to_operator(p_string):
	if(p_string == "=="):
		return COMPARISON_OPERATOR_EQUALS
	elif(p_string == "!="):
		return COMPARISON_OPERATOR_NOT
	elif(p_string == ">"):
		return COMPARISON_OPERATOR_GREATER
	elif(p_string == "<"):
		return COMPARISON_OPERATOR_LESSER
	elif(p_string == ">="):
		return COMPARSION_OPERATOR_EQUALS_OR_GREATER
	elif(p_string == "<="):
		return COMPARISON_OPERATOR_EQUALS_OR_LESSER
	else:
		printerr("string_to_operator: invalid!")
		return COMPARISON_OPERATOR_EQUALS
		
static func operator_to_string(p_operator):
	if(p_operator == COMPARISON_OPERATOR_EQUALS):
		return "=="
	elif(p_operator == COMPARISON_OPERATOR_NOT):
		return "!="
	elif(p_operator == COMPARISON_OPERATOR_GREATER):
		return ">"
	elif(p_operator == COMPARISON_OPERATOR_LESSER):
		return "<"
	elif(p_operator == COMPARSION_OPERATOR_EQUALS_OR_GREATER):
		return ">="
	elif(p_operator == COMPARISON_OPERATOR_EQUALS_OR_LESSER):
		return "<="
	else:
		printerr("operator_to_string: invalid!")
		return "=="
		
static func get_array_of_operator_strings():
	return ["==", "!=", ">", "<", ">=", "<="]
	
static func get_array_of_subjects():
	return ["self", "target", "reference", "global"]
	
static func get_array_of_value_type_strings():
	return ["float", "string", "svar", "boolean"]
		
static func string_to_subject(p_string):
	if(p_string == "self"):
		return CONDITIONAL_SUBJECT_SELF
	elif(p_string == "target"):
		return CONDITIONAL_SUBJECT_TARGET
	elif(p_string == "reference"):
		return CONDITIONAL_SUBJECT_REFERENCE
	elif(p_string == "global"):
		return CONDITIONAL_SUBJECT_GLOBAL
	else:
		printerr("string_to_subject: invalid!")
		return CONDITIONAL_SUBJECT_SELF
		
static func subject_to_string(p_subject):
	if(p_subject == CONDITIONAL_SUBJECT_SELF):
		return "self"
	elif(p_subject == CONDITIONAL_SUBJECT_TARGET):
		return "target"
	elif(p_subject == CONDITIONAL_SUBJECT_REFERENCE):
		return "reference"
	elif(p_subject == CONDITIONAL_SUBJECT_GLOBAL):
		return "global"
	else:
		printerr("subject_to_string: invalid!")
		return "self"
		
static func string_to_value_type(p_string):
	if(p_string == "float"):
		return VALUE_TYPE_FLOAT
	elif(p_string == "string"):
		return VALUE_TYPE_STRING
	elif(p_string == "svar"):
		return VALUE_TYPE_SVAR
	elif(p_string == "boolean"):
		return VALUE_TYPE_BOOLEAN
	else:
		printerr("string_to_value_type: invalid!")
		return VALUE_TYPE_FLOAT
		
static func value_type_to_string(p_subject):
	if(p_subject == VALUE_TYPE_FLOAT):
		return "float"
	elif(p_subject == VALUE_TYPE_STRING):
		return "string"
	elif(p_subject == VALUE_TYPE_SVAR):
		return "svar"
	elif(p_subject == VALUE_TYPE_BOOLEAN):
		return "boolean"
	else:
		printerr("value_type_to_string: invalid!")
		return "float"
		
static func load_from_dictionary(p_conditional_set, p_dictionary, p_databases):
	if(p_dictionary != null and p_dictionary.has("conditional_items")):
		var dictionary = methods_const.get_master_method_dict()
		
		p_conditional_set.conditional_items.clear()
		
		for conditional_dictionary in p_dictionary.conditional_items:
			var method_template = null
			if(dictionary.has(conditional_dictionary.conditional_method)):
				method_template = dictionary[conditional_dictionary.conditional_method]
			
				var conditional_item = ConditionalItem.new()
				conditional_item.conditional_method = conditional_dictionary.conditional_method
			
				conditional_item.arguments.clear()
				if(conditional_dictionary.has("conditional_arguments")):
					for i in range(0, conditional_dictionary.conditional_arguments.size()):
						var argument = conditional_dictionary.conditional_arguments[i]
						var argument_template = method_template.arguments[i]
						if(argument_template.type == methods_const.ARGUMENT_TYPE_OBJECT):
							if(argument_template.options.has("database")):
								var database = p_databases.get(argument_template.options["database"])
								conditional_item.arguments.push_back(database.find_record_by_name(str(argument)))
						elif(argument_template.type == methods_const.ARGUMENT_TYPE_ENUM):
							if(argument_template.options.size() > 0):
								var argument_enums = argument_template.options["enums"]
								var argument_enum_value = argument_enums[0]
								for option in argument_enums:
									if(argument == option.option_name):
										argument_enum_value = option.option_value
										break
								conditional_item.arguments.push_back(argument_enum_value)
						else:
							conditional_item.arguments.push_back(argument)
					
				conditional_item.operator = string_to_operator(conditional_dictionary.operator)
				conditional_item.value = conditional_dictionary.value
				conditional_item.value_type = string_to_value_type(conditional_dictionary.value_type)
				conditional_item.subject = string_to_subject(conditional_dictionary.subject)
				conditional_item.use_or = conditional_dictionary.use_or
				
				p_conditional_set.conditional_items.push_back(conditional_item)

static func save_to_dictionary(p_conditional_set, p_database):
	var conditionals = []
	
	var dictionary = methods_const.get_master_method_dict()
	
	for conditional_item in p_conditional_set.conditional_items:
		var method_template = null
		if(dictionary.has(conditional_item.conditional_method)):
			method_template = dictionary[conditional_item.conditional_method]
			var conditional_dictionary = {}
			
			conditional_dictionary.conditional_method = conditional_item.conditional_method
			
			conditional_dictionary.conditional_arguments = []
			for i in range(0, conditional_item.arguments.size()):
				var argument = conditional_item.arguments[i]
				var argument_template = method_template.arguments[i]
				
				if(argument_template.type == methods_const.ARGUMENT_TYPE_OBJECT):
					conditional_dictionary.conditional_arguments.push_back(argument.id)
				elif(argument_template.type == methods_const.ARGUMENT_TYPE_ENUM):
					if(argument_template.options.size() > 0):
						var argument_enums = argument_template.options["enums"]
						var argument_enum_name = argument_enums[0]
						for argument_enum in argument_enums:
							if(argument == argument_enum.option_value):
								argument_enum_name = argument_enum.option_name
								break
						conditional_dictionary.conditional_arguments.push_back(argument_enum_name)
				else:
					conditional_dictionary.conditional_arguments.push_back(argument)
				
			conditional_dictionary.operator = operator_to_string(conditional_item.operator)
			conditional_dictionary.value = conditional_item.value
			conditional_dictionary.value_type = value_type_to_string(conditional_item.value_type)
			conditional_dictionary.subject = subject_to_string(conditional_item.subject)
			conditional_dictionary.use_or = conditional_item.use_or
			
			conditionals.push_back(conditional_dictionary)
		
	return {"conditional_items":conditionals}
		
