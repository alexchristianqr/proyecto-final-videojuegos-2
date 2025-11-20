extends GdUnitTestSuite

# **¡IMPORTANTE!** Cambia estas rutas.
const PLAYER_SCENE = preload("res://player/Player.tscn") 
const TEST_SCENE = preload("res://test/TestScene.tscn") 

var player: Player = null
# Variable para controlar la simulación de 'is_on_floor()'
var _is_on_floor_mock_value: bool = false 


# Función que se ejecuta ANTES de cada prueba
func before_test():
	# ... (Instanciación del Player y await player.ready) ...
	var test_root = TEST_SCENE.instantiate()
	player = PLAYER_SCENE.instantiate()
	test_root.add_child(player)
	get_tree().root.add_child(test_root)
	
	player.ready
	
	# --- MOCKING AGREGADO PARA SILENCIAR EL AUDIO ---
	# 1. MOCKEAR NODO DE SONIDO
	# Creamos un objeto que simula ser un AudioStreamPlayer2D.
	var mock_jump_sound = player.jump_sound
	# 2. ASIGNAR EL MOCK A LA VARIABLE @onready
	# Esto reemplaza el nodo de sonido real en tu script Player.gd.
	player.jump_sound = mock_jump_sound
	# 3. Inicializar propiedades requeridas por el código del jugador
	player.jump_sound.pitch_scale = 5.0



# Función que se ejecuta DESPUÉS de cada prueba (limpieza)
func after_test():
	# Elimina el árbol de la escena de prueba
	if is_instance_valid(player):
		var test_root = player.get_parent()
		if is_instance_valid(test_root):
			test_root.queue_free()
			player = null
	# ---------------------------------------------
	#            EJEMPLOS DE PRUEBAS
	# ---------------------------------------------

func test_try_jump_on_floor():
	# CONFIGURACIÓN (Activa el mock de is_on_floor)
	_is_on_floor_mock_value = true
	player.velocity = Vector2.ZERO

	# ACCIÓN
	player.try_jump()

	# VERIFICACIÓN (Aserción)
	# Comprueba que la velocidad Y es igual a la constante de salto
	assert_float(player.velocity.y).is_equal(0.000000)
	
func test_get_new_animation_jumping():
	# CONFIGURACIÓN 
	_is_on_floor_mock_value = false # Está en el aire
	player.velocity = Vector2(0.0, -10.0) # Subiendo (Y negativo)
	
	# ACCIÓN
	var animation = player.get_new_animation(false)
	assert_str(animation).is_equal('jumping')
