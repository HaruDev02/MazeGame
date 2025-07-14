extends Area2D

signal collected

func _ready() -> void:
	area_entered.connect(func(area: Area2D): 
		emit_signal("collected")
		queue_free()	
	)
