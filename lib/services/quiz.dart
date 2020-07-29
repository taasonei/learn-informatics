class Answer {
  String answerText;
  bool correct;
  Answer({this.correct, this.answerText});

  Answer.fromMap(Map data) {
    answerText = data['answerText'];
    correct = data['correct'];
  }
}

class Question {
  String questionText;
  List<Answer> answers;
  Question({this.answers, this.questionText});

  Question.fromMap(Map data) {
    questionText = data['questionText'] ?? '';
    answers =
        (data['answers'] as List ?? []).map((v) => Answer.fromMap(v)).toList();
  }
}

class Quiz {
  List<Question> questions;
  Quiz({this.questions});

  factory Quiz.fromMap(Map data) {
    return Quiz(
        questions: (data['questions'] as List ?? [])
            .map((v) => Question.fromMap(v))
            .toList());
  }
}
