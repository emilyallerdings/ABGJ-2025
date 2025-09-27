extends Decal
class_name DecalCorrupt

@export var textMerger : TextMerger
@export var textures : Array[TextureRect]
@export var targetLabel : Label
@export var targetViewport : SubViewport

func _ready() -> void:
	get_tree().get_first_node_in_group("Office").new_corruption_level.connect(update_decal)

func update_decal(lerpAmount : float):
	#Text Fade
	if textMerger != null:
		targetLabel.text = textMerger.mix_strings(lerpAmount)
	#Image Fade
	if textures.size() > 0:
		textures[0].modulate = Color.WHITE.lerp(Color.TRANSPARENT, 1 - lerpAmount)
		textures[1].modulate = Color.WHITE.lerp(Color.TRANSPARENT, lerpAmount)
	#Take a new snapshot
	targetViewport.render_target_update_mode = targetViewport.UPDATE_ONCE
	await RenderingServer.frame_post_draw
	var setImage : Image = targetViewport.get_texture().get_image()
	texture_albedo = ImageTexture.create_from_image(setImage)
