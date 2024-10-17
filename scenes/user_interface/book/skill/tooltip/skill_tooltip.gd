class_name SkillTooltip
extends MarginContainer


var _skill : Skill


func _ready() -> void :
	print("Hey")


func _update_controls() -> void :
	(%Header as Label).text = _skill.get_header()
	(%Description as RichTextLabel).text = "[center]%s[/center]" %_skill.get_description()
	(%SoullEssenceCost as Label).text = "Soul Essence Cost : %s" %_skill.get_cost()


func set_skill_name(skill_name : String ) -> void : 
	_skill = SkillsManager.ref.get_skill(skill_name)
	
	_update_controls()
