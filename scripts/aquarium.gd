extends Node2D

@export var character_scene: PackedScene
@onready var aquarium_area = $AquariumArea  # Tempat karakter muncul

func add_character(data: Dictionary) -> void:
	if character_scene:
		var character_instance = character_scene.instantiate()
		
		# Konfigurasi bentuk, ekspresi, dan warna
		var shape_sprite = character_instance.get_node("ShapeSprite")
		var expression_sprite = character_instance.get_node("ExpressionSprite")
		
		shape_sprite.texture = load(data["shape"])
		expression_sprite.texture = load(data["expression"])
		
		var material = shape_sprite.material
		if aquarium_area:
			aquarium_area.add_child(character_instance)
		else:
			print("Error: aquarium_area not found!")
			
		print("aquarium_area:", aquarium_area)
		
		 # Atur ukuran karakter dengan scale
		character_instance.scale = Vector2(0.14, 0.14)  # Ukuran setengah dari ukuran asli (contoh)

		# Terapkan warna dengan ShaderMaterial
		if material and material is ShaderMaterial:
			material.set_shader_parameter("replace_color", data["color"])
			material.set_shader_parameter("tolerance", 1.0)
		
		# Atur posisi acak di dalam Aquarium
		var viewport_size = get_viewport_rect().size
		var random_position = Vector2(
			randf_range(0, viewport_size.x),
			randf_range(0, viewport_size.y)
		)
		character_instance.position = random_position

		# Tambahkan ke node AquariumArea
		aquarium_area.add_child(character_instance)
	else:
		print("Error: character_scene is not set!")
