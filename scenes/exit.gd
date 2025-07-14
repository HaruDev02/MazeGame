extends Area2D

func _ready() -> void:
	visible = true
	area_entered.connect(func(_area: Area2D) -> void:
		print("Player exited")
	)
