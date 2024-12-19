extends Node2D

@onready var shape_sprite = $ShapeSprite  # Node untuk bentuk karakter
@onready var expression_sprite = $ExpressionSprite  # Node untuk ekspresi karakter

func set_character_properties(shape_color: Color, shape_texture: Texture, expression_texture: Texture):
	# Mengatur warna bentuk karakter
	if shape_sprite.material and shape_sprite.material is ShaderMaterial:
		var shader = shape_sprite.material
		shader.set_shader_param("replace_color", shape_color)
	else:
		shape_sprite.modulate = shape_color

	# Mengatur tekstur bentuk karakter
	if shape_texture:
		shape_sprite.texture = shape_texture
		

	# Mengatur ekspresi karakter
	if expression_texture:
		expression_sprite.texture = expression_texture
