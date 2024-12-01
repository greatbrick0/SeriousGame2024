extends Panel

var questionIndex: int = 0
@export var questions: Array[QuizQuestion]

func _ready():
	questionIndex = 0
	SetUpQuestion(questions[questionIndex])

func SetUpQuestion(qq: QuizQuestion) -> void:
	match qq.questionType:
		QuizQuestion.qTypes.FourChoice:
			SetUpFourChoice(qq)
		QuizQuestion.qTypes.NumberAnswer:
			SetUpNumberAnswer(qq)

func SetUpFourChoice(qq: QuizQuestion) -> void:
	$FourChoiceQuestion.visible = true
	$FourChoiceQuestion/Panel/Label.text = qq.questionText
	for ii in 4:
		$FourChoiceQuestion/Panel.get_node("Answer"+str(ii+1)).text = qq.options[ii]

func SetUpNumberAnswer(qq: QuizQuestion) -> void:
	$NumberAnswer.visible = true
	$NumberAnswer/Label.text = qq.questionText
	$NumberAnswer/SpinBox.suffix = qq.options[0]

func FourChoiceAnswer(buttonIndex: int) -> void:
	$FourChoiceQuestion.visible = false
	if(questions[questionIndex].options[buttonIndex] == questions[questionIndex].questionAnswer):
		SetResults(true, "That is correct!")
	else:
		SetResults(false, "Incorrect! The answer was: " + questions[questionIndex].questionAnswer + "!")

func NumberAnswer() -> void:
	$NumberAnswer.visible = false
	var units = questions[questionIndex].options[0]
	if(str($NumberAnswer/SpinBox.value) == questions[questionIndex].questionAnswer):
		SetResults(true, questions[questionIndex].questionAnswer + units + " is correct!")
	else:
		SetResults(false, "The answer was not " + str($NumberAnswer/SpinBox.value) + units + "! \nThe answer was: " + questions[questionIndex].questionAnswer + units + "!")

func SetResults(correct: bool, response: String) -> void:
	$Result.visible = true
	$Result/Label.text = response

func ResultsContinue() -> void:
	questionIndex += 1
	if(questionIndex >= len(questions)):
		HudManager.SetMouseLocked(true)
		queue_free()
	else:
		$Result.visible = false
		SetUpQuestion(questions[questionIndex])
