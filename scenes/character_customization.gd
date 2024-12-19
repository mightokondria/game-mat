extends Control

@onready var shape_sprite = $PreviewSprite/ShapeSprite  # Sprite untuk bentuk
@onready var expression_sprite = $PreviewSprite/ExpressionSprite  # Sprite untuk ekspresi
@onready var shape_options = [
	"res://assets/bentuk/bentuk-01.png",
	"res://assets/bentuk/bentuk-03.png",
	"res://assets/bentuk/bentuk-04.png",
	"res://assets/bentuk/bentuk-05.png",
	"res://assets/bentuk/bentuk-06.png"]
@onready var expression_options = [
	"res://assets/emosi/emosi-02.png",
	"res://assets/emosi/emosi-07.png",
	"res://assets/emosi/emosi-08.png",
	"res://assets/emosi/emosi-09.png",
	"res://assets/emosi/emosi-10.png"]
@onready var color_options = [
	Color("#1e3c78"),  # Biru
	Color("#e0e0e0"),  # Abu-abu
	Color("#0b0c0f"),  # Hitam
	Color("#3fb3b2"),  # Turquoise
	Color("#d91f21")   # Merah (default)
]

var current_shape_index: int = 0
var current_expression_index: int = 0
var current_color_index: int = 4  # Default merah

func _ready():
	# Hubungkan tombol ke fungsi masing-masing
	$VBoxContainer/ChangeShapeButton.pressed.connect(_on_change_shape_pressed)
	$VBoxContainer/ChangeColorButton.pressed.connect(_on_change_color_pressed)
	$VBoxContainer/ChangeExpressionButton.pressed.connect(_on_change_expression_pressed)

	# Atur material shader untuk ShapeSprite
	var shader_material = ShaderMaterial.new()
	shader_material.shader = load("res://scenes/ColorSwap.gdshader")  # Pastikan shader path benar
	shape_sprite.material = shader_material

	# Atur warna awal
	shader_material.set_shader_parameter("target_color", Color("#d91f21"))  # Warna default
	shader_material.set_shader_parameter("replace_color", Color("#0b0c0f"))
	shader_material.set_shader_parameter("tolerance", 1.0)

func _on_change_color_pressed() -> void:
	# Ganti warna karakter dengan shader
	current_color_index = (current_color_index + 1) % color_options.size()
	var shader_material = shape_sprite.material as ShaderMaterial
	if shader_material:
		shader_material.set_shader_parameter("replace_color", color_options[current_color_index])

func _on_change_shape_pressed() -> void:
	# Ganti bentuk karakter
	current_shape_index = (current_shape_index + 1) % shape_options.size()
	var new_texture: Texture2D = load(shape_options[current_shape_index])
	shape_sprite.texture = new_texture

func _on_change_expression_pressed() -> void:
	# Ganti ekspresi karakter
	current_expression_index = (current_expression_index + 1) % expression_options.size()
	var new_texture: Texture2D = load(expression_options[current_expression_index])
	expression_sprite.texture = new_texture


func _on_generate_button_pressed() -> void:
	var aquarium_scene = preload("res://scenes/Aquarium.tscn") # Path ke scene aquarium
	var aquarium_instance = aquarium_scene.instance()
	var player_character = generate_character()
	get_tree().change_scene_to(aquarium_scene)
	# Menambahkan karakter ke aquarium nanti diatur di dalam scene tersebut.

func generate_character() -> Dictionary:
	return {
		"shape": shape_options[current_shape_index],
		"color": color_options[current_color_index],
		"expression": expression_options[current_expression_index]
	}
