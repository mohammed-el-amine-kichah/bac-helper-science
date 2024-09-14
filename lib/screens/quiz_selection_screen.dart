import 'package:bac_helper_sc/components/feature_card.dart';
import 'package:bac_helper_sc/provider/dark_mode.dart';
import 'package:bac_helper_sc/screens/quiz_game_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';

class Quiz {
  final String type;
  final String asset;


  Quiz({required this.type, required this.asset});
}

class QuizSelectionScreen extends StatelessWidget {
  const QuizSelectionScreen({super.key});
  void _showUnitSelectionDialog(bool isDarkMode,BuildContext context, String quizType) {
    if (quizType == 'مصطلحات الجغرافيا' || quizType == 'مصطلحات التاريخ')
      Navigator.push(context, MaterialPageRoute(builder: (context) =>  QuizGameScreen(quizType: quizType, s:'الوحدة الأولى',)));

   else showDialog(context: context,
        builder: (BuildContext context) {
             return AlertDialog(
                title: const Text('اختر الوحدة', textAlign: TextAlign.center,),
               content:
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                     GestureDetector(
                       child:Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color:  isDarkMode ? const Color(0xFF484848) : Colors.white ,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: isDarkMode ? Colors.grey : Colors.grey.shade300 , // Updated to reflect dynamic border color
                      width: 1,
                    ),
                  ),
                  child: const Text(
                    textAlign: TextAlign.center,
                    'الوحدة الأولى',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                                ),
                       onTap: (){
                         Navigator.of(context).pop(); // Close the dialog
                         Navigator.push(context, MaterialPageRoute(builder: (context) =>  QuizGameScreen(quizType: quizType, s:'الوحدة الأولى',)));
                       },
                     ),
                      GestureDetector(
                        child:Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color:  isDarkMode ? const Color(0xFF484848) : Colors.white ,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: isDarkMode ? Colors.grey : Colors.grey.shade300 , // Updated to reflect dynamic border color
                              width: 1,
                            ),
                          ),
                          child: const Text(
                            textAlign: TextAlign.center,
                            'الوحدة الثانية',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        onTap: (){
                          Navigator.of(context).pop(); // Close the dialog
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>  QuizGameScreen(quizType: quizType, s: 'الوحدة الثانية', )));
                        },
                      ),
                      GestureDetector(
                        child:Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color:  isDarkMode ? const Color(0xFF484848) : Colors.white ,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: isDarkMode ? Colors.grey : Colors.grey.shade300 , // Updated to reflect dynamic border color
                              width: 1,
                            ),
                          ),
                          child: const Text(
                            textAlign: TextAlign.center,
                            'الوحدة الثالثة',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        onTap: (){
                          Navigator.of(context).pop(); // Close the dialog
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>  QuizGameScreen(quizType: quizType,s: 'الوحدة الثالثة',)));
                        },
                      ),

                    ],

                ),
              );
        }
    );

  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeNotifier>(context).isDarkMode;
    final List<Quiz> quizzes = [
      Quiz(type: 'تواريخ', asset: 'assets/images/lessons.svg'),
      Quiz(type: 'شخصيات', asset: 'assets/images/lessons.svg'),
      Quiz(type: 'مصطلحات الجغرافيا', asset: 'assets/images/lessons.svg'),
      Quiz(type: 'مصطلحات التاريخ', asset: 'assets/images/lessons.svg'),

    ];
    return PopScope(
      canPop: false, // Set this to false to handle the back button press ourselves
      onPopInvokedWithResult: (bool didPop, dynamic result) async {
        if (didPop) return;
        // Navigate to HomePage when the back button is pressed
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const HomePage()),
              (route) => false, // This removes all previous routes
        );

      },


    child:  SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
                child: const Icon(Icons.arrow_back,color: Colors.white,),
                onTap: (){
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const HomePage()),
                        (route) => false, // This removes all previous routes
                  );
                }
            ),
            centerTitle: true,
            backgroundColor: Colors.deepPurple,
            title: const Text('قائمة التحديات',style: TextStyle(color: Colors.white,fontSize: 24),),
          ),
          body: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Expanded(
                    child: GridView.count(
                        crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      children: quizzes.map( (quiz) =>
                          FeatureCardComponent(
                              imageAsset: quiz.asset,
                              title: quiz.type,
                              onTap: () {
                                _showUnitSelectionDialog(isDarkMode,context, quiz.type);
                              })

                      ).toList(

                      ),
                    )
                )

              ],
            ),

          ),
        )
    )
    );
  }
}
