extends Node

@onready var terminal_ui = $TerminalUI  

func _ready():
	# Test adding some terminal text
	terminal_ui.add_text("Welcome to the Submarine Terminal.")
	terminal_ui.add_text("Systems initialized.")
