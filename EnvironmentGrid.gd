extends Node3D

var camera
@export var BlockScene: PackedScene
@export var size_x = 100
@export var size_y = 100
@export var cell_size = 1
@onready var player = $CharacterBody3D

# Called when the node enters the scene tree for the first time.
func _ready():
	camera = $CharacterBody3D/Camera3D
	pass # Replace with function body.
	
func respect_da_grid(pos):
	return Vector3(round(pos.x), pos.y, round(pos.z))
	
func in_player_range(pos):
	return pos.distance_to(player.position) <= 5

func _input(event):
	if event.is_action_pressed("Left_Click"):
		var mousePos = get_viewport().get_mouse_position()
		var rayLength = 100
		var from = camera.project_ray_origin(mousePos)
		var to = from + camera.project_ray_normal(mousePos) * rayLength
		var space = get_world_3d().direct_space_state
		var rayQuery = PhysicsRayQueryParameters3D.new()
		rayQuery.from = from
		rayQuery.to = to
		rayQuery.collide_with_areas = true
		var result = space.intersect_ray(rayQuery)
		#var new_pos = respect_da_grid(Vector3(result["position"].x, result["position"].y + 0.5, result["position"].z))
		var new_pos = respect_da_grid(Vector3(result["position"].x, 2.52, result["position"].z))
		if in_player_range(new_pos):
			var block = BlockScene.instantiate()
			add_child(block)
			block.position = new_pos

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
