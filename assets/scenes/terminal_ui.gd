extends Control

# Store the terminal text
var terminal_text = ""

# Reference to the Label node that will display the text
@onready var label = $Label  

# Method to add text to the terminal
func add_text(new_text: String) -> void:
	terminal_text += new_text + "\n"  
	label.text = terminal_text  

# Clear the terminal
func clear_terminal() -> void:
	terminal_text = ""
	label.text = terminal_text
