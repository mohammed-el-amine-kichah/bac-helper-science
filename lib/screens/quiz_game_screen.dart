import 'package:bac_helper_sc/screens/quiz_selection_screen.dart';
import 'package:flutter/material.dart';
import '../models/fetch_quiz_questions.dart'; // Ensure this is the only import for Question

class QuizGameScreen extends StatefulWidget {
  const QuizGameScreen({super.key});

  @override
  State<QuizGameScreen> createState() => _QuizGameScreenState();
}

class _QuizGameScreenState extends State<QuizGameScreen> {
  List<Question> questionList = getQuestions();
  int currentQuestionIndex = 0;
  int score = 0;
  Answer? selectedAnswer;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Text(
                'تواريخ الوحدة الأولى',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: LinearProgressIndicator(
                  borderRadius: BorderRadius.circular(15),
                  minHeight: 4,
                  backgroundColor: Colors.grey.shade200,
                  value: (currentQuestionIndex + 1) / questionList.length,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 2),
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width * 0.8,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                    color:  Colors.grey.shade300,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                child: Text(
                  questionList[currentQuestionIndex].questionText,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16,),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
              _answerList(),
              Spacer(),
              _nextButton(),
              SizedBox(height: 20), // Adds 20px space from the bottom
            ],
          ),
        ),
      ),
    );
  }

  Widget _nextButton() {
    bool isLastQuestion = currentQuestionIndex == questionList.length - 1;

    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      height: 48,
      child: ElevatedButton(
        child: Text(isLastQuestion ? "النتيجة" : "التالي",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
        ),
        onPressed: () {
          if (selectedAnswer == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('يرجى اختيار اجابة',textAlign: TextAlign.center,style: TextStyle(fontSize: 24),),
                duration: Duration(seconds: 1,milliseconds: 500), // Duration for which the SnackBar is displayed
                behavior: SnackBarBehavior.floating, // Ensures the SnackBar stays at the bottom
                backgroundColor: Colors.redAccent, // Customize the background color
              ),
            );
          } else {
            if (isLastQuestion) {
              if (selectedAnswer!.isCorrect) {
                score++;
              }
              showDialog(context: context, builder: (_) => _showScoreDialog());
            } else {
              setState(() {
                if (selectedAnswer!.isCorrect) {
                  score++;
                }
                selectedAnswer = null;
                currentQuestionIndex++;
              });
            }
          }
        },
      ),
    );
  }

  Widget _showScoreDialog() {
    final String remark = switch (score) {
      >= 0 && <= 3 => "يمكنك تحقيق الأفضل",
      >= 4 && <= 6 => "متوسط، واصل الحفظ",
      >= 7 && <= 8 => " نتيجة حسنة",
      9 => "جيد جدا، واصل",
      10 => "أسطورة يا قمر",
      _ => "خطأ فني بسيط"
    };
    return AlertDialog(
      title: Text(
        " نتيجتك هي : $score / 10 ",
        textAlign : TextAlign.end,
        style: TextStyle(fontSize: 18),
      ),
      content:
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('$remark',
                textAlign: TextAlign.end,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ElevatedButton(
                    child: const Text("العودة"),
                    style: ElevatedButton.styleFrom(
                     backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const QuizSelectionScreen()));

                    },
                  ),
                ],
              ),
            ],
          )

    );
  }

  Widget _answerList() {
    return Column(
      children: questionList[currentQuestionIndex]
          .answersList
          .map((e) => _answerButton(e))
          .toList(),
    );
  }

  Widget _answerButton(Answer answer) {
    bool isSelected = answer == selectedAnswer;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedAnswer = answer;
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.deepPurple : Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected ? Colors.deepPurple : Colors.grey.shade300,
            width: 1,
          ),
        ),
        child: Text(
          textAlign: TextAlign.center,
          answer.answerText,
          style: TextStyle(
            fontSize: 18,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
