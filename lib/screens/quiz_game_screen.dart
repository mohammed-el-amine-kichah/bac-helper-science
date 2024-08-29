import 'dart:async';

import 'package:bac_helper_sc/provider/dark_mode.dart';
import 'package:bac_helper_sc/screens/quiz_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../models/fetch_quiz_questions.dart';


class QuizGameScreen extends StatefulWidget {
  final String quizType;
  final String s;
  QuizGameScreen({required this.quizType,required this.s, super.key});

  @override
  State<QuizGameScreen> createState() => _QuizGameScreenState();
}

class _QuizGameScreenState extends State<QuizGameScreen> {
 List<Question> questionList = [];
  int currentQuestionIndex = 0;
  int score = 0;
  bool isRightAnswer = false;
  double length = 0;
  Answer? selectedAnswer;
  Answer? correctAnswer;
  bool isAnswered = false; // To track if the user has answered
 bool showErrorMessage = false;
 @override
 void initState() {
   super.initState();

   // Initialize questionList here
   questionList = getQuizQuestions(widget.quizType, widget.s);
   length =  widget.quizType == 'شخصيات' ? 0.28 : 0.15;
 }

 void _showErrorMessage() {
   setState(() {
     showErrorMessage = true; // Show the success message container
   });

   // Hide the container after 1 second
   Timer(const Duration(milliseconds: 2700), () {
     setState(() {
       showErrorMessage = false; // Hide the success message container
     });
   });
 }
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeNotifier>(context).isDarkMode;
    return PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, dynamic result) async {
          if (didPop) return;

          final shouldPop = await _showExitConfirmationDialog(isDarkMode);

          if (shouldPop) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const QuizSelectionScreen()),
                  (route) => false,
            );
          }

        },

   child:  SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.03),
               Text(
                widget.quizType + ' ' + widget.s,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.8,
                child: LinearProgressIndicator(
                  color: isDarkMode ? Colors.deepPurple.shade400 : Colors.deepPurple.shade300,
                  borderRadius: BorderRadius.circular(15),
                  minHeight: 4,
                  backgroundColor: isDarkMode? Colors.grey.shade400 : Colors.grey.shade200 ,
                  value: (currentQuestionIndex + 1) / questionList.length,
                ),
              ),
              SizedBox(height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.1),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                height: MediaQuery
                    .of(context)
                    .size
                    .height  * length,
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.8,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isDarkMode ? Colors.grey : Colors.grey.shade300,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(15),
                  color: isDarkMode ? const Color(0xFF484848): Colors.white,
                ),
                child: Text(
                  questionList[currentQuestionIndex].questionText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.05,
              ),
              _answerList(isDarkMode),
              const Spacer(),
                  if (showErrorMessage)
                    Center(
                      child: Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width * 0.8,
                          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xFFDFC4C4),
                              width: 1,
                            ),
                            color: const Color(0xFFF4D5D5),
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1), // Shadow color
                                spreadRadius: 2, // How much the shadow spreads
                                blurRadius: 10, // How blurred the shadow is
                                offset: const Offset(0, 4), // Shadow position (x, y)
                              ),
                            ],
                          ),

                          child:
                          Row(
                            children: [
                              Image.asset('assets/images/fail_icon.png'),
                              const Spacer(),
                              const Text(
                                'يرجي اختيار اجابة',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  color: Color(0xFFD71A1A),
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          )

                      ). animate()
                          .shimmer(delay : 200.ms, duration: 1800.ms)
                          .shake(hz:3, curve: Curves.easeInOutCubic)
                          .scaleXY(end: 1.1, duration: 600.ms)
                          .then(delay: 600.ms)
                          .scaleXY(end: 1/1.1),
                    ),
                  if(!showErrorMessage)
                    _nextButton(),
                  const SizedBox(height: 20,),


            ],
          ),
        ),
      ),
   )
    );
  }

  Widget _nextButton() {
    bool isLastQuestion = currentQuestionIndex == questionList.length - 1;

    return SizedBox(
      width: MediaQuery
          .of(context)
          .size
          .width * 0.4,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
        ),
        onPressed: () {
          if (selectedAnswer == null) {
           _showErrorMessage();
          } else {
            // Mark that the question has been answered
            isAnswered = true;

            // Highlight correct and incorrect answers
            setState(() {
              correctAnswer = questionList[currentQuestionIndex]
                  .answersList
                  .firstWhere((answer) => answer.isCorrect);
            });

            if (selectedAnswer!.isCorrect) {
              score++;
            }

            // Delay moving to the next question
            Future.delayed(const Duration(milliseconds: 500), () {
              if (isLastQuestion) {
                showDialog(
                    context: context, builder: (_) => _showScoreDialog());
              } else {
                setState(() {
                  isRightAnswer = false;
                  isAnswered = false;
                  selectedAnswer = null;
                  currentQuestionIndex++;
                });
              }
            });
          }
        },
        child: Text(
          isLastQuestion ? "النتيجة" : "التالي",
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
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
          textAlign: TextAlign.end,
          style: const TextStyle(fontSize: 18),
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              remark,
              textAlign: TextAlign.end,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                            const QuizSelectionScreen()));
                  },
                  child: const Text("العودة"),
                ),
              ],
            ),
          ],
        ));
  }

  Widget _answerList(bool dark) {
    return Column(
      children: questionList[currentQuestionIndex]
          .answersList
          .map((e) => _answerButton(e,dark))
          .toList(),
    );
  }
  Future<bool> _showExitConfirmationDialog(bool dark) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('هل تريد الخروج من الاختبار؟',textAlign: TextAlign.end,style: TextStyle(fontSize: 19),),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('نتيجتك الحالية : $score / ${currentQuestionIndex + 1}',textAlign: TextAlign.end),
              const SizedBox(height: 15,),
              Row(
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.deepPurple,
                    ),
                    child: const Text('استمرار'),
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                  const SizedBox(width: 15,),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: dark ? Colors.white: Colors.black,
                      backgroundColor: dark? Colors.grey :  Colors.grey.shade200 ,
                    ),
                    child: const Text('الخروج'),
                    onPressed: () => Navigator.of(context).pop(true),
                  ),
                ],
              ),

            ],
          )


        );
      },
    ) ?? false; // If the dialog is dismissed, default to false
  }
  Widget _answerButton(Answer answer , bool dark) {
    bool isSelected = answer == selectedAnswer;
    Color buttonColor = dark? const Color(0xFF484848):Colors.white ; // Default button color
    Color textColor = dark? Colors.white :Colors.black;   // Default text color
    Color borderColor = dark ? Colors.grey : Colors.grey.shade300; // Default border color

    if (isAnswered) {
      if (answer.isCorrect) {
        buttonColor = Colors.green;  // Correct answers will be green
        textColor = Colors.white;    // Text color for correct answers
        borderColor = Colors.green;  // Correct answer border color
      } else if (isSelected && !answer.isCorrect) {
        buttonColor = Colors.red;    // Incorrect selected answers will be red
        textColor = Colors.white;    // Text color for incorrect selected answers
        borderColor = Colors.red;    // Incorrect answer border color
      } else {
        borderColor = Colors.grey.shade300; // Unselected answers' border
      }
    } else if (isSelected) {
      buttonColor = Colors.deepPurple;  // Selected but not yet confirmed
      textColor = Colors.white;         // Text color when selected
      borderColor = Colors.deepPurple;  // Border color for selected answer
    }

    return GestureDetector(
      onTap: () {
        if (!isAnswered) {
          setState(() {
            selectedAnswer = answer;
          });
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: borderColor, // Updated to reflect dynamic border color
            width: 1,
          ),
        ),
        child: Text(
          textAlign: TextAlign.center,
          answer.answerText,
          style: TextStyle(
            fontSize: 18,
            color: textColor, // Ensure text color is set based on the conditions
          ),
        ),
      ),
    );
  }

}
