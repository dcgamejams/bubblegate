extends Control

const SERVER_ADDRESS: String = "127.0.0.1"
const SERVER_PORT: int = 9999
const MAX_PLAYERS : int = 10

const player_scene = preload("res://quality-godot-first-person/addons/fpc/character.tscn")

var players = {}
var player_info = {
	"nick" : "host",
	"color" : "blue"
}

func _ready() -> void:
	multiplayer.server_disconnected.connect(_on_connection_failed)
	multiplayer.connection_failed.connect(_on_server_disconnected)
	multiplayer.peer_disconnected.connect(_on_player_disconnected)
	multiplayer.peer_connected.connect(_on_player_connected)
	multiplayer.connected_to_server.connect(_on_connected_ok)
	#var args = OS.get_cmdline_user_args()
	#for arg in args:
		#var key_value = arg.rsplit("=")
		#match key_value[0]:
			#"server":
				#print('DEBUG: SERVER STARTING `-- server` found')
				#start_host()
	
func _on_connected_ok():
	var peer_id = multiplayer.get_unique_id()
	players[peer_id] = player_info
	
func _on_player_connected(id):
	if Hub.players_container.has_node(str(id)) or not multiplayer.is_server() or id == 1:
		return
	player_info["nick"] = "Player_" + str(multiplayer.get_unique_id())
	_register_player.rpc_id(id, player_info)
	
	var player = player_scene.instantiate()
	player.name = str(id)
	Hub.players_container.add_child(player, true)
		
	# TODO: 
	#for id in Network.players.keys():
		#var _player_data = Network.players[id]
		#if id != peer_id:
			# These are client only syncs, to set player properties.
			#rpc_id(peer_id, "sync_player_skin", id, player_data["skin"])
			#rpc_id(peer_id, "sync_player_skin", id, player_data["skin"])
func on_host():
	hide()
	
func join():
	pass

func _on_player_disconnected(id):
	players.erase(id)

func _on_connection_failed():
	multiplayer.multiplayer_peer = null
	get_tree().quit()

func _on_server_disconnected():
	multiplayer.multiplayer_peer = null
	players.clear()
	#Hub.server_disconnected.emit()

@rpc("any_peer", "reliable")
func _register_player(new_player_info):
	var new_player_id = multiplayer.get_remote_sender_id()
	players[new_player_id] = new_player_info
	#Hub.player_connected.emit(new_player_id, new_player_info)
	
func _remove_player(id):
	if not multiplayer.is_server() or not Hub.players_container.has_node(str(id)):
		return
	var player_node = Hub.players_container.get_node(str(id))
	if player_node:
		player_node.queue_free()

func _add_player(id):
	var player = player_scene.instantiate()
	player.name = str(id)
	Hub.players_container.add_child(player, true)

func _on_quit_pressed() -> void:
	get_tree().quit()
