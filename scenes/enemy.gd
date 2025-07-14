extends Area2D

const TILE_SIZE := Vector2(16, 16)
const MOVE_DIRS = [Vector2(-1, 0), Vector2(1, 0), Vector2(0, -1), Vector2(0, 1)]

@export_range(0, 1) var _tween_duration := 0.165

@onready var _enemy_sprite: Sprite2D = %Sprite2D
@onready var raycast_up: RayCast2D = %RaycastUp
@onready var raycast_down: RayCast2D = %RaycastDown
@onready var raycast_left: RayCast2D = %RaycastLeft
@onready var raycast_right: RayCast2D = %RaycastRight

var sprite_node_pos_tween: Tween

func _physics_process(delta: float) -> void:
	#var raycast_to_player := Raycast2D
	pass
	

func _move(dir: Vector2) -> void:
	global_position += TILE_SIZE * dir
	_enemy_sprite.global_position -= TILE_SIZE * dir
	
	if sprite_node_pos_tween:
		sprite_node_pos_tween.kill()
	
	sprite_node_pos_tween = create_tween()
	sprite_node_pos_tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	sprite_node_pos_tween.tween_property(_enemy_sprite, "global_position", global_position, _tween_duration).set_trans(Tween.TRANS_SINE)

func _can_move(dir: Vector2) -> bool:
	if dir.x == -1 and raycast_left.is_colliding():
		return false
	elif dir.x == 1 and raycast_right.is_colliding():
		return false
	elif dir.y == 1 and raycast_down.is_colliding():
		return false
	elif dir.y == -1 and raycast_up.is_colliding():
		return false
	return true

func _on_move_timer_timeout() -> void:
	var random_dir: Vector2 = MOVE_DIRS[randi_range(0, len(MOVE_DIRS) - 1)]
	while !_can_move(random_dir):
		random_dir = MOVE_DIRS[randi_range(0, len(MOVE_DIRS) - 1)]
	_move(random_dir)
