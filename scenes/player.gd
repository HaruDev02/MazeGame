extends Area2D

const TILE_SIZE := Vector2(16, 16)

@export_range(0, 1) var _tween_duration := 0.165

@onready var _raycast_up: RayCast2D = %RaycastUp
@onready var _raycast_down: RayCast2D = %RaycastDown
@onready var _raycast_left: RayCast2D = %RaycastLeft
@onready var _raycast_right: RayCast2D = %RaycastRight
@onready var _player_sprite: Sprite2D = %Sprite2D

var sprite_node_pos_tween: Tween

func _process(_delta: float) -> void:
	if !sprite_node_pos_tween or !sprite_node_pos_tween.is_running():
		if Input.is_action_pressed("move_down") and !_raycast_down.is_colliding():
			_move(Vector2(0, 1))
		elif Input.is_action_pressed("move_left") and !_raycast_left.is_colliding():
			_move(Vector2(-1, 0))
		elif Input.is_action_pressed("move_right") and !_raycast_right.is_colliding():
			_move(Vector2(1, 0))
		elif Input.is_action_pressed("move_up") and !_raycast_up.is_colliding():
			_move(Vector2(0, -1))

func _move(dir: Vector2) -> void:
	global_position += TILE_SIZE * dir
	_player_sprite.global_position -= TILE_SIZE * dir
	
	if sprite_node_pos_tween:
		sprite_node_pos_tween.kill()
	
	sprite_node_pos_tween = create_tween()
	sprite_node_pos_tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	sprite_node_pos_tween.tween_property(_player_sprite, "global_position", global_position, _tween_duration).set_trans(Tween.TRANS_SINE)
