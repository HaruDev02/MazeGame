extends Control

@onready var _restart_button: Button = %RestartButton
@onready var _quit_button: Button = %QuitButton
@onready var _exit: Area2D = %Exit
@onready var _game_over_text: Label = %GameOverText

func _ready() -> void:
	hide()
	_restart_button.pressed.connect(get_tree().reload_current_scene)
	_quit_button.pressed.connect(get_tree().quit)
	_exit.player_exited_level.connect(
		func():
			show()
			_game_over_text.text = "You Win!"
			get_tree().paused = true
	)


func game_over() -> void:
	show()
	get_tree().paused = true
