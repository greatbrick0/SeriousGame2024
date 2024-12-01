extends Resource
class_name QuizQuestion

enum qTypes {
	FourChoice,
	TwoChoice,
	ShortAnswer,
	NumberAnswer
}

@export var questionText: String = "?"
@export var questionType: qTypes = qTypes.FourChoice
@export_multiline var questionAnswer: String = "..."
@export_multiline var options: Array[String]
