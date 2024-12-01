extends Node3D

@export var npcName: String = "Prof. Doctor"
@export_multiline var npcInfo: String = "Vaping is bad"

func _ready():
	$InteractArea.hoverText = npcName

func _process(delta):
	$"Standing Idle/AnimationPlayer".play("mixamo_com")

func _on_interact_area_activated(ref):
	ref.get_node("Label").text = npcInfo
