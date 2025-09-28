extends Node3D
class_name OfficeKeyboard

@export var keyPrefab : PackedScene

const KEYS = {
	KEY_Q : "Q",
	KEY_W : "W",
	KEY_E : "E",
	KEY_R : "R",
	KEY_T : "T",
	KEY_Y : "Y",
	KEY_U : "U",
	KEY_I : "I",
	KEY_O : "O",
	KEY_P : "P",
	
	KEY_A : "A",
	KEY_S : "S",
	KEY_D : "D",
	KEY_F : "F",
	KEY_G : "G",
	KEY_H : "H",
	KEY_J : "J",
	KEY_K : "K",
	KEY_L : "L",
	
	KEY_Z : "Z",
	KEY_X : "X",
	KEY_C : "C",
	KEY_V : "V",
	KEY_B : "B",
	KEY_N : "N",
	KEY_M : "M"
}

var keyCorruptOrder : Array

var keyLookup : Dictionary

func _ready() -> void:
	#Key Indexing
	for keyIndex in KEYS.values().size():
		var eachKey : String = KEYS.values()[keyIndex]
		var keyVis : VisualKey = keyPrefab.instantiate()
		keyVis.name = eachKey + "Key"
		keyVis.set_key(eachKey)
		keyLookup[KEYS.keys()[keyIndex]] = keyVis
		add_child(keyVis)
		if keyIndex < 10:
			keyVis.position = Vector3.FORWARD * (keyIndex * 1)
		elif keyIndex < 19:
			keyVis.position += Vector3.RIGHT + Vector3.FORWARD * (keyIndex - 9.8 * 1)
		else:
			keyVis.position += (Vector3.RIGHT * 2) + Vector3.FORWARD * (keyIndex - 18.5 * 1)
	
	#Corruption
	get_tree().get_first_node_in_group("Office").new_corruption_level.connect(corrupt_keys)
	keyCorruptOrder = keyLookup.keys().duplicate()
	keyCorruptOrder.shuffle()
	
	await get_tree().process_frame
	print(get_tree().get_first_node_in_group("Office").new_corruption_level.get_connections())

func _input(event: InputEvent) -> void:
	if not Office.PoweredOn:
		return
	if event is InputEventKey and event.is_pressed():
		if OfficeKeyboard.KEYS.has(event.keycode):
			keyLookup[event.keycode].press()

func corrupt_keys(lerpAmount : float):
	var keysToCorrupt = min(25, int(keyCorruptOrder.size() * lerpAmount))
	for eachKey in keysToCorrupt:
		var keyToUse = Office.CorruptText[eachKey % Office.CorruptText.length()]
		keyLookup[keyCorruptOrder[eachKey]].set_key(keyToUse.to_upper())
