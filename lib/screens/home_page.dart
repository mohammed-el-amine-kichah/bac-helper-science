

import 'package:bac_helper_sc/components/feature_card.dart';
import 'package:bac_helper_sc/screens/bac_exams_and_solutions.dart';
import 'package:bac_helper_sc/screens/modules_screen.dart';
import 'package:bac_helper_sc/screens/quiz_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/content_type.dart';
import '../provider/dark_mode.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            'الصفحة الرئيسية',
            style: textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontSize: 20, // Explicitly set font size
            ),
            textDirection: TextDirection.rtl,
          ),
          centerTitle: true,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
          actions: [
            IconButton(
              icon: Icon(
                themeNotifier.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                color: Colors.white,
              ),
              onPressed: () {
                themeNotifier.toggleTheme();
              },
            ),
          ],
        ),
        drawer: Drawer(

          width: MediaQuery.of(context).size.width * 0.75,
          child: Container(
            color: Colors.deepPurple,
            child: ListView(
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.deepPurple, // Background color of the drawer header

                  ),

                  child: Align(
                    alignment: Alignment.center, // Centers the content inside the DrawerHeader
                    child: Text(
                      'رفيق البكالوريا',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24, // Adjust the font size as needed
                        fontWeight: FontWeight.bold, // Optional: makes the text bold
                      ),
                    ),
                  ),
                ),
                const ListTile(
                  leading: Icon(Icons.apps,color: Colors.white),
                  title: Text("تطبيقاتنا",textDirection: TextDirection.rtl,style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(height: 10,),
                const ListTile(
                  leading: Icon(Icons.star, color: Colors.yellow),
                  title: Text("تقييم التطبيق",textDirection: TextDirection.rtl,style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(height: 10,),
                ListTile(
                  leading: const Icon(Icons.feedback,color: Colors.white,),
                  title: const Text("اقتراح فكرة",textDirection: TextDirection.rtl,style: TextStyle(color: Colors.white)),
                  onTap: _launchGoogleForm,
                ),
                const SizedBox(height: 10,),
                const ListTile(
                  leading: Icon(Icons.info,color: Colors.white) ,
                  title: Text("حول التطبيق",textDirection: TextDirection.rtl,style: TextStyle(color: Colors.white)),
                ),
              ],

            ),
          ),
        ),
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.center,
           children: [
            Text(
              'مرحبا بك' , textDirection: TextDirection.rtl,
              style: textTheme.headlineMedium?.copyWith(
                fontSize: 30, // Explicitly set font size
              ),
            ),

             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Text(
                 'رَبِّ زِدْنِي عِلْمًا' , textDirection: TextDirection.rtl,
                 style: textTheme.headlineMedium?.copyWith(
                   fontSize: 20, // Explicitly set font size
                 ),
               ),
             ),

             const SizedBox(height: 20,),
             Expanded(
                 child: GridView.count(
                     crossAxisCount: 2,
                   crossAxisSpacing: 8,
                   mainAxisSpacing: 8,
                   children: [

                     FeatureCardComponent(
                         imageAsset:  'assets/images/progress.svg',
                         title: 'نسبة التقدم',
                         onTap: (){

                         }
                     ),
                     FeatureCardComponent(
                         imageAsset:  'assets/images/quiz.svg',
                         title: 'اختبر معلوماتك',
                         onTap: (){
                           Navigator.push(context, MaterialPageRoute(builder: (context) => const QuizSelectionScreen()));

                         }
                     ),
                     FeatureCardComponent(
                         imageAsset:  'assets/images/to_do_list.svg',
                         title: 'قائمة المهام',
                         onTap: (){

                         }
                     ),
                     FeatureCardComponent(
                         imageAsset:  'assets/images/flash_card.svg',
                         title: 'بطاقات المراجعة',
                         onTap: (){
                           Navigator.push(
                               context,
                               MaterialPageRoute(
                               builder: (context) => const ModulesScreen(mycontentType: LearningContentType.flashCards),
                           ),
                           );
                         }
                     ),
                     FeatureCardComponent(
                         imageAsset:  'assets/images/resources.svg',
                         title: 'مصادر',
                         onTap: (){

                         }
                     ),

                     FeatureCardComponent(
                         imageAsset:  'assets/images/exo.svg',
                         title: 'تمارين',
                         onTap: (){

                         }
                     ),
                     FeatureCardComponent(
                         imageAsset:  'assets/images/lessons.svg',
                         title: 'دروس',
                         onTap: (){
                           Navigator.push(
                               context,
                               MaterialPageRoute(
                               builder: (context) => const ModulesScreen(mycontentType: LearningContentType.lessons),
                           ),
                           );
                         }
                     ),
                     FeatureCardComponent(
                         imageAsset:  'assets/images/sujet_bac.svg',
                         title: 'مواضيع و حلول',
                         onTap: (){
                           Navigator.push(context, MaterialPageRoute(builder: (context) => BacExamsAndSolutions()));

                         }
                     ),

                     FeatureCardComponent(
                         imageAsset:  'assets/images/timer.svg',
                         title: 'الوقت المتبقي',
                         onTap: (){
                                Navigator.pushNamed(context, 'timer');
                         }
                     ),
                     FeatureCardComponent(
                         imageAsset:  'assets/images/calculator_icon.svg',
                         title: 'حساب المعدل',
                         onTap: (){
                           Navigator.pushNamed(context, 'calculator');

                         }
                     ),

                   ],
                 )
             )

          ]
          ),
        ),
      ),
    );
  }
  void _launchGoogleForm() async {
    final Uri googleFormUrl = Uri.parse('https://forms.gle/VRsjy6QZkS4WvD399');  // Replace with your actual Google Form URL

    if (!await launchUrl(googleFormUrl, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $googleFormUrl';
    }
  }
}
