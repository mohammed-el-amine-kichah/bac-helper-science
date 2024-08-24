import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/feature_card.dart';
import '../flashCards/sc_flash_card.dart';
import '../models/content_type.dart';
import '../provider/dark_mode.dart';

class Subject {
  final String name;
  final String asset;

  Subject({required this.name, required this.asset});
}

class ModulesScreen extends StatelessWidget {
  final LearningContentType mycontentType;

  const ModulesScreen({super.key,required this.mycontentType,});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    final List<Subject> subjects = [
      Subject(name: 'الرياضيات', asset: 'assets/images/lessons.svg'),
      Subject(name: 'علوم الطبيعة والحياة', asset: 'assets/images/lessons.svg'),
      Subject(name: 'العلوم الفزيائية', asset: 'assets/images/lessons.svg'),
      Subject(name: 'اللغة العربية', asset: 'assets/images/lessons.svg'),
      Subject(name: 'اللغة الفرنسية', asset: 'assets/images/lessons.svg'),
      Subject(name: 'اللغة الانجليزية', asset: 'assets/images/lessons.svg'),
      Subject(name: 'الاجتماعيات', asset: 'assets/images/lessons.svg'),
      Subject(name: 'العلوم الاسلامية', asset: 'assets/images/lessons.svg'),
      Subject(name: 'الفلسفة', asset: 'assets/images/lessons.svg'),
    ];

    return SafeArea(
      child: Scaffold(
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
                      children: subjects.map((subject) =>
                          FeatureCardComponent(
                            imageAsset: subject.asset,
                            title: subject.name,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ContentPage(
                                    moduleName: subject.name,
                                    contentType: mycontentType,
                                  ),
                                ),
                              );
                            },
                          )
                      ).toList(),
                    )
                )
              ]
          ),
        ),
      ),
    );
  }
}