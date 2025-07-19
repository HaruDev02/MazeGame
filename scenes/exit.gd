extends Area2D

signal player_exited_level

@onready var _collision_shape_2d: CollisionShape2D = %CollisionShape2D

func _ready() -> void:
	hide()
	_collision_shape_2d.disabled = true
	area_entered.connect(func(_area: Area2D) -> void:
		player_exited_level.emit()
	)

func toggle() -> void:
	show()
	_collision_shape_2d.set_deferred("disabled", false)
