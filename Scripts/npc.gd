extends Node3D

@export var npcName: String = "Prof. Doctor"
@export_multiline var npcMonologue: String = "Vaping is bad"
@export var heightMult: float = 1.0

func _ready():
	$"Standing Idle".scale *= heightMult
	$InteractArea.hoverText = npcName

func _process(delta):
	$"Standing Idle/AnimationPlayer".play("mixamo_com")

func _on_interact_area_activated(ref):
	ref.get_node("Label").text = npcMonologue
