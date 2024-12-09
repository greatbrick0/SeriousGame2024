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
		QuizQuestion.qTypes.TwoChoice:
			SetUpTwoChoice(qq)
		QuizQuestion.qTypes.ShortAnswer:
			SetUpShortAnswer(qq)
		QuizQuestion.qTypes.NumberAnswer:
			SetUpNumberAnswer(qq)

func SetUpFourChoice(qq: QuizQuestion) -> void:
	$FourChoiceQuestion.visible = true
	$FourChoiceQuestion/Panel/Label.text = qq.questionText
	for ii in 4:
		$FourChoiceQuestion/Panel.get_node("Answer"+str(ii+1)).text = qq.options[ii]

func SetUpTwoChoice(qq: QuizQuestion) -> void:
	$TwoChoiceQuestion.visible = true
	$TwoChoiceQuestion/Label.text = qq.questionText
	$TwoChoiceQuestion/HSplit/TrueButton.text = qq.options[0]
	$TwoChoiceQuestion/HSplit/FalseButton.text = qq.options[1]

func SetUpShortAnswer(qq: QuizQuestion) -> void:
	$ShortAnswer.visible = true
	$ShortAnswer/Label.text = qq.questionText
	$ShortAnswer/TextEdit.placeholder_text = qq.options[0]
	$ShortAnswer/TextEdit.text = ""

func SetUpNumberAnswer(qq: QuizQuestion) -> void:
	$NumberAnswer.visible = true
	$NumberAnswer/Label.text = qq.questionText
	$NumberAnswer/SpinBox.suffix = qq.options[0]
	$NumberAnswer/SpinBox.value = 0 if len(qq.options) == 1 else int(qq.options[1])

func FourChoiceAnswer(buttonIndex: int) -> void:
	$FourChoiceQuestion.visible = false
	if(questions[questionIndex].options[buttonIndex] == questions[questionIndex].questionAnswer):
		SetResults(true, "That is correct!")
	else:
		SetResults(false, "Incorrect! The answer was: " + questions[questionIndex].questionAnswer + "!")

func TwoChoiceAnswer(response: bool) -> void:
	$TwoChoiceQuestion.visible = false
	if(str(response).to_lower() == questions[questionIndex].questionAnswer.to_lower()):
		SetResults(true, "That is correct!")
	else:
		SetResults(false, "That is incorrect!")

func ShortAnswer() -> void:
	if($ShortAnswer/TextEdit.text == ""): return
	$ShortAnswer.visible = false
	if($ShortAnswer/TextEdit.text.to_lower() == questions[questionIndex].questionAnswer.to_lower()):
		SetResults(true, "\"" + $ShortAnswer/TextEdit.text + "\" is correct!")
	else:
		SetResults(false, "The answer was not \"" + $ShortAnswer/TextEdit.text + "\"! \nThe answer was \"" + questions[questionIndex].questionAnswer + "\"!")

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
