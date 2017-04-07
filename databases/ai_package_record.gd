extends "generic_record.gd"

const date_and_time_const = preload("res://addons/date_and_time/date_and_time.gd")
#
const conditionals_const = preload("../conditionals/conditionals.gd")
const ai_procedure_tree_const = preload("../ai/ai_procedure_tree.gd")

class Schedule extends Resource:
	const DAY_FLAG_SUNDAY = 1
	const DAY_FLAG_MONDAY = 2
	const DAY_FLAG_TUESDAY = 4
	const DAY_FLAG_WEDNESDAY = 8
	const DAY_FLAG_THURSDAY = 16
	const DAY_FLAG_FRIDAY = 32
	const DAY_FLAG_SATURDAY = 64

	const DAY_FLAG_WEEKDAYS = 62
	const DAY_FLAG_WEEKENDS = 65

	export(float) var duration = 0.0

	export(int) var start_minutes = -1
	export(int) var start_hours = -1

	export(int) var week_month_flag = 0
	export(int) var days_flag = 0

var conditionals = conditionals_const.new()
var schedule = Schedule.new()
var flags = 0

func _load_record(p_dictionary_record, p_databases):
	# Read Data
	._load_record(p_dictionary_record, p_databases)

func _save_record(p_dictionary_record, p_databases):
	# Write Data
	._save_record(p_dictionary_record, p_databases)