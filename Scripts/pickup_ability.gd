extends Node2D


func _on_area_2d_body_entered(body: Node2D) -> void:
	Globals.double_jump_unlocked = true
	$Sprite2D.visible = false
