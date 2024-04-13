extends Node

enum Type { NULL, RED, GREEN, BLUE, YELLOW, WHITE, BLACK }

var typeInfo: Dictionary = {
	Type.NULL: {"name": "Null", "strengths": [], "weaknesses": [], "color": Color.TRANSPARENT},
	Type.RED:
	{"name": "Red", "strengths": [Type.GREEN], "weaknesses": [Type.BLUE], "color": Color.RED},
	Type.GREEN:
	{"name": "Green", "strengths": [Type.BLUE], "weaknesses": [Type.RED], "color": Color.GREEN},
	Type.BLUE:
	{"name": "Blue", "strengths": [Type.RED], "weaknesses": [Type.GREEN], "color": Color.BLUE},
	Type.YELLOW:
	{
		"name": "Yellow",
		"strengths": [Type.WHITE],
		"weaknesses": [Type.BLACK],
		"color": Color.YELLOW
	},
	Type.WHITE:
	{"name": "White", "strengths": [Type.BLACK], "weaknesses": [Type.YELLOW], "color": Color.WHITE},
	Type.BLACK:
	{"name": "Black", "strengths": [Type.YELLOW], "weaknesses": [Type.WHITE], "color": Color.BLACK}
}

@export var type1: Type = Type.NULL
@export var type2: Type = Type.NULL
