extends Control

var terminal_text = ""

@onready var label = $Label

# add text to the terminal
func add_text(new_text: String) -> void:
	terminal_text += new_text + "\n"
	label.text = terminal_text
	
# clear the terminal
func clear_terminal() -> void:
	terminal_text = ""
	label.text = terminal_text
