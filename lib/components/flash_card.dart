import 'dart:convert';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:provider/provider.dart';

import '../provider/dark_mode.dart';

class FlashCard {
  final String question;
  final String answer;

  FlashCard({required this.question, required this.answer});

  factory FlashCard.fromJson(Map<String, dynamic> json) {
    return FlashCard(
      question: json['question'],
      answer: json['answer'],
    );
  }
}

Future<List<FlashCard>> loadFlashCards(String moduleId) async {
  final String jsonString = await rootBundle.loadString('assets/data/flash_cards.json');
  final Map<String, dynamic> jsonData = json.decode(jsonString);

  if (jsonData.containsKey(moduleId)) {
    return (jsonData[moduleId] as List)
        .map((item) => FlashCard.fromJson(item))
        .toList();
  }
  return [];
}


// Your existing buildFlashCardWidget, buildBackFace, and buildFrontFace functions remain the same
Widget buildFlashCardWidget(
    BuildContext context, String question, String answer , ) {
  return Container(
    height: (MediaQuery.of(context).size.height) * 0.4,
    width: (MediaQuery.of(context).size.width) * 0.8,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(24),
      // Add a subtle shadow for depth
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 10,
          spreadRadius: 2,
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: FlipCard(
        direction: FlipDirection.VERTICAL,
        front: buildFrontFace(context, question),
        back: buildBackFace(context, answer),
      ),
    ),
  );
}

Widget buildBackFace(BuildContext context, String answer) {
  final themeNotifier = Provider.of<ThemeNotifier>(context);
  return Container(
    decoration: BoxDecoration(

      color: themeNotifier.isDarkMode ? Colors.black87 : Colors.grey.shade300,
      borderRadius: BorderRadius.circular(24),
    ),
    child: Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Text(answer,style: TextStyle(fontSize: 24),textAlign: TextAlign.center,),
      ),
    ),
  );
}

Widget buildFrontFace(BuildContext context, String question) {
  final themeNotifier = Provider.of<ThemeNotifier>(context);
  return Container(
    decoration: BoxDecoration(
      color: themeNotifier.isDarkMode ? Colors.black87 : Colors.grey.shade300,
      borderRadius: BorderRadius.circular(24),
    ),
    child: Center(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Text(question,style: TextStyle(fontSize: 24),textAlign: TextAlign.center,),
    )),
  );
}
