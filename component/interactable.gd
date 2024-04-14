extends Node

@export var dialogue: DialogueResource = null
var dialogue_box: Control = null
var dialogue_label: DialogueLabel = null
@onready var menu_sound: AudioStreamPlayer = $MenuSound


func _ready() -> void:
	if dialogue:
		await get_tree().process_frame
		dialogue_box = get_tree().get_root().get_node("Main/DialogueBox")
		dialogue_label = dialogue_box.dialogue_label


func interact() -> bool:
	menu_sound.play()
	if dialogue and dialogue_box.visible == false:
		dialogue_box.show()
		var dialogue_line = await dialogue.get_next_dialogue_line("this_is_a_node_title")
		dialogue_label.dialogue_line = dialogue_line
		await dialogue_label.type_out()
		return true
	elif dialogue and dialogue_box.visible == true:
		if dialogue_label.is_typing:
			dialogue_label.skip_typing()
		else:
			var next_id: String = dialogue_label.dialogue_line.next_id
			var dialogue_line: DialogueLine = await dialogue.get_next_dialogue_line(next_id)
			if dialogue_line:
				dialogue_label.dialogue_line = dialogue_line
				await dialogue_label.type_out()
			else:
				dialogue_box.hide()
				return false
		return true
	return false
