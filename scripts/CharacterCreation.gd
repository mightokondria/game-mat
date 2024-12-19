extends Control

# Menghubungkan node PreviewSprite
@onready var preview_sprite = $PreviewSprite
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

var current_shape_index = 0
var current_color_index = 0
var current_expression_index = 0

#func _on_change_shape_pressed():
	## Ganti bentuk karakter
	#var i = 0
	#i += 1
	#current_shape_index = (current_shape_index + 1) % shape_options.size()
	#shape_sprite.texture = load(shape_options[current_shape_index])  # Menggunakan shape_sprite
	#print("bentuk ganti" + str(i))

#func _on_change_color_pressed():
	## Ganti warna karakter dengan shader
	#var i = 0
	#i += 1
	#current_color_index = (current_color_index + 1) % color_options.size()
	#var material = ShaderMaterial.new()
	#material.set_shader(preload("res://scenes/ColorSwap.gdshader"))
	#material.set_shader_param("replace_color", color_options[current_color_index])
	#shape_sprite.material = material  # Menggunakan shape_sprite
	#print("warna ganti" + str(i))

#func _on_change_expression_pressed():
	## Ganti ekspresi karakter
	#var i = 0
	#i += 1
	#current_expression_index = (current_expression_index + 1) % expression_options.size()
	#expression_sprite.texture = load(expression_options[current_expression_index])  # Menggunakan expression_sprite
	#print("ekspresi ganti" + str(i))

#func _on_generate_pressed():
	## Mengirim data karakter ke scene Aquarium
	#var data = {
		#"shape": shape_options[current_shape_index],
		#"color": color_options[current_color_index],
		#"expression": expression_options[current_expression_index]
	#}
	#var aquarium_scene = preload("res://scenes/Aquarium.tscn")
	#var aquarium_instance = aquarium_scene.instantiate()
	#get_tree().root.add_child(aquarium_instance)
	#get_tree().current_scene.queue_free()
	#aquarium_instance.add_character(data)
	
#-----FUNGSI BARU-----


func _on_change_shape_button_pressed() -> void:
	# Ganti bentuk karakter
	var i = 0
	i += 1
	current_shape_index = (current_shape_index + 1) % shape_options.size()
	shape_sprite.texture = load(shape_options[current_shape_index])  # Menggunakan shape_sprite
	print("bentuk ganti" + str(i))


func _on_change_color_button_pressed() -> void:
	# Ganti warna karakter dengan shader
	current_color_index = (current_color_index + 1) % color_options.size()
	var material = shape_sprite.material
	if material and material is ShaderMaterial:
		material.set_shader_parameter("replace_color", color_options[current_color_index])
		material.set_shader_parameter("tolerance", 1.0)  # Atur toleransi menjadi 1.0


func _on_change_expression_button_pressed() -> void:
	# Ganti ekspresi karakter
	var i = 0
	i += 1
	current_expression_index = (current_expression_index + 1) % expression_options.size()
	expression_sprite.texture = load(expression_options[current_expression_index])  # Menggunakan expression_sprite
	print("ekspresi ganti" + str(i))


func _on_generate_button_pressed() -> void:
	# Data karakter dari pilihan saat ini
	var data = {
		"shape": shape_options[current_shape_index],
		"color": color_options[current_color_index],
		"expression": expression_options[current_expression_index]}

	# Pindah ke scene Aquarium
	var aquarium_scene = preload("res://scenes/Aquarium.tscn")
	var aquarium_instance = aquarium_scene.instantiate()
	get_tree().current_scene.queue_free()  # Tutup scene sebelumnya
	get_tree().root.add_child(aquarium_instance)
	
	# Tambahkan karakter ke aquarium
	aquarium_instance.add_character(data)
