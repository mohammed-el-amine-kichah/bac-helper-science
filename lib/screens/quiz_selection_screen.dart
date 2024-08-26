import 'package:bac_helper_sc/components/feature_card.dart';
import 'package:bac_helper_sc/screens/quiz_game_screen.dart';
import 'package:flutter/material.dart';

class Quiz {
  final String type;
  final String asset;

  Quiz({required this.type, required this.asset});
}

class QuizSelectionScreen extends StatelessWidget {
  const QuizSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Quiz> quizzes = [
      Quiz(type: 'تواريخ', asset: 'assets/images/lessons.svg'),
      Quiz(type: 'شخصيات', asset: 'assets/images/lessons.svg'),
      Quiz(type: 'مصطلحات الجغرافيا', asset: 'assets/images/lessons.svg'),
      Quiz(type: 'مصطلحات التاريخ', asset: 'assets/images/lessons.svg'),

    ];


    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
                child: const Icon(Icons.arrow_back,color: Colors.white,),
                onTap: (){
                  Navigator.pop(context);
                }
            ),
            centerTitle: true,
            backgroundColor: Colors.deepPurple,
            title: const Text('قائمة التحديات',style: TextStyle(color: Colors.white,fontSize: 24),),
          ),
          body: Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
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
                                Navigator.push(context, MaterialPageRoute(builder: (context) => QuizGameScreen()));

                              })

                      ).toList(

                      ),
                    )
                )

              ],
            ),

          ),
        ));
  }
}
