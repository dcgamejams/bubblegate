extends Node2D

func _ready():
	Hub.players_container = $PlayersContainer
	Hub.environment_container = $EnvironmentContainer
