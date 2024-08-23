import 'package:bac_helper_sc/components/feature_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/dark_mode.dart';

class HomePage extends StatelessWidget {
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
                icon: Icon(
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
          child: Container(
            color: themeNotifier.isDarkMode ? Colors.deepPurple : Colors.deepPurple[100],
            child: ListView(
              children: [
                DrawerHeader(child: Text('رفيق البكالوريا',textDirection: TextDirection.rtl)),
                ListTile(
                  leading: Icon(Icons.apps),
                  title: Text("تطبيقاتنا",textDirection: TextDirection.rtl,),
                ),
                const SizedBox(height: 10,),
                ListTile(
                  leading: Icon(Icons.star, color: Colors.yellow),
                  title: Text("تقييم التطبيق",textDirection: TextDirection.rtl,),
                ),
                const SizedBox(height: 10,),
                ListTile(
                  leading: Icon(Icons.feedback),
                  title: Text("اقتراح فكرة",textDirection: TextDirection.rtl,),
                ),
                const SizedBox(height: 10,),
                ListTile(
                  leading: Icon(Icons.info) ,
                  title: Text("حول التطبيق",textDirection: TextDirection.rtl,),
                ),
              ],

            ),
          ),
        ),
        body: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
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

             SizedBox(height: 20,),
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

                         }
                     ),
                     FeatureCardComponent(
                         imageAsset:  'assets/images/sujet_bac.svg',
                         title: 'مواضيع و حلول',
                         onTap: (){

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
}