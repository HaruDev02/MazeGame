extends Node2D

@onready var _exit_layer: TileMapLayer = %ExitLayer
var collectibles_count := 0

func _ready() -> void:
	_exit_layer.hide()
	var collectibles := get_tree().get_nodes_in_group("Collectibles")
	collectibles_count = collectibles.size()
	for collectible in collectibles:
		collectible.connect("collected", collectible_collected)

func collectible_collected() -> void:
	collectibles_count -= 1
	if collectibles_count == 0:
		_exit_layer.show()
