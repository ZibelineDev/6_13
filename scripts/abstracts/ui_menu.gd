class_name UIMenu
extends Control


func close() -> void : 
	visible = false
	UserInterface.ref.ui_element_closed()
