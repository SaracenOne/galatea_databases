extends "generic_record.gd"

const date_and_time_const = preload("res://addons/date_and_time/date_and_time.gd")

export(String) var printed_name = ""
export(String) var calendar_icon_path = ""

export(int) var start_date_day = 1
export(int) var start_date_month = OS.MONTH_JANUARY

export(int) var end_date_day = 1
export(int) var end_date_month = OS.MONTH_JANUARY

export(bool) var is_school_holiday = false
export(bool) var is_hidden = false

func _load_record(p_dictionary_record, p_databases):
	# Read Data
	._load_record(p_dictionary_record, p_databases)
	
	if(p_dictionary_record.has("printed_name")):
		printed_name = p_dictionary_record.printed_name
	if(p_dictionary_record.has("calendar_icon_path")):
		calendar_icon_path = p_dictionary_record.calendar_icon_path
	
	if(p_dictionary_record.has("start_date_day")):
		start_date_day = p_dictionary_record.start_date_day
	if(p_dictionary_record.has("start_date_month")):
		start_date_month = date_and_time_const.get_month_from_string(p_dictionary_record.start_date_month)
	if(p_dictionary_record.has("end_date_day")):
		end_date_day = p_dictionary_record.end_date_day
	if(p_dictionary_record.has("end_date_month")):
		end_date_month = date_and_time_const.get_month_from_string(p_dictionary_record.end_date_month)
	
	# Flags
	if(p_dictionary_record.has("is_school_holiday")):
		is_school_holiday = p_dictionary_record.is_school_holiday
	if(p_dictionary_record.has("is_hidden")):
		is_hidden = p_dictionary_record.is_hidden
		
func _save_record(p_dictionary_record, p_databases):
	# Write Data
	._save_record(p_dictionary_record, p_databases)
	
	p_dictionary_record.printed_name = printed_name
	p_dictionary_record.calendar_icon_path = calendar_icon_path
	
	p_dictionary_record.start_date_day = start_date_day
	p_dictionary_record.start_date_month = date_and_time_const.get_string_from_month(start_date_month)
	p_dictionary_record.end_date_day = end_date_day
	p_dictionary_record.end_date_month = date_and_time_const.get_string_from_month(end_date_month)
	
	#Flags
	p_dictionary_record.is_school_holiday = is_school_holiday
	p_dictionary_record.is_hidden = is_hidden