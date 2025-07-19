extends Node2D

@onready var player: Area2D = %Player
@onready var enemy: Area2D = %Enemy
@onready var start_timer: Timer = %StartTimer
@onready var exit: Area2D = %Exit
@onready var game_over_screen: Control = %GameOverScreen
@onready var game_node: Node2D = get_node("Game")

var collectibles_count := 0

func _ready() -> void:
	var collectibles := get_tree().get_nodes_in_group("Collectibles")
	collectibles_count = collectibles.size()
	for collectible in collectibles:
		collectible.connect("collected", collectible_collected)
		
	for enemy in get_tree().get_nodes_in_group("Enemy"):
		enemy.hit_player.connect(game_over)
	
func collectible_collected() -> void:
	collectibles_count -= 1
	if collectibles_count == 0:
		exit.toggle()

func game_over() -> void:
	game_over_screen.game_over()
