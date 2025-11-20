# ---------------------------------------------
#            PRUEBAS DE VERIFICACIÓN SECUENCIAL
# ---------------------------------------------

extends GdUnitTestSuite

func test_01_simple_arithmetic():
	# Verifica una operación aritmética simple
	var a = 10
	var b = 6
	var result = a * b
	assert_int(result).is_equal(60)

func test_02_string_comparison():
	# Verifica que dos cadenas son iguales
	var expected = String("Hello World")
	var actual = String("Hello World")
	assert_str(actual).is_equal(expected)

func test_03_array_contains():
	# Verifica que un array contiene un elemento específico
	var colors = ["red", "green", "blue"]
	var expec : String = "red"

	assert_bool(colors.has(expec)).is_true()


func test_04_boolean_fail_check():
	# Esta prueba fallará intencionalmente para ver cómo se reporta el error
	var is_night = true
	assert_bool(is_night).is_false()

func test_05_float_range():
	# Verifica que un valor flotante cae dentro de un rango aceptable
	var speed = 300.5
	assert_float(speed).is_between(299.0, 301.0)
