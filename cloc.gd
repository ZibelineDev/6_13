@tool
extends EditorScript
var count_code : int = 0
var count_comments : int = 0
var count_total : int = 0


func _run() -> void:
	count_dir("res://")
	OS.alert("%s lines of code\n%s comments\n%s total lines" % [count_code, count_comments, count_total])


func count_dir(path: String) -> void :
	var directories : PackedStringArray = DirAccess.get_directories_at(path)
	for d : String in directories:
		if d == "addons":
			continue
		if path == "res://":
			count_dir(path + d)
		else:
			count_dir(path + "/" + d)
	
	var files : PackedStringArray = DirAccess.get_files_at(path)
	
	for f : String in files:
		if not f.get_extension() == "gd":
			continue
		var file : FileAccess = FileAccess.open(path + "/" + f, FileAccess.READ)
		var lines : PackedStringArray = file.get_as_text().split("\n")
		
		for line : String in lines:
			count_total += 1
			if line.strip_edges().begins_with("#"):
				count_comments += 1
				continue
			if line.strip_edges() != "":
				count_code += 1
