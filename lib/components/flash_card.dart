import 'dart:convert';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:provider/provider.dart';

import '../models/database_helper.dart';
import '../provider/dark_mode.dart';

class FlashCard {
  final String question;
  final String answer;
  final int?  id;

  FlashCard({this.id,required this.question, required this.answer});

  // Convert a map to a FlashCard
  factory FlashCard.fromJson(Map<String, dynamic> json) {
    return FlashCard(
      id: json['id'] as int?,
      question: json['question'] as String,
      answer: json['answer'] as String,
    );
  }

  // Convert a FlashCard to a map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'answer': answer,
    };
  }
}

Future<List<FlashCard>> loadFlashCards(String moduleId) async {
  List<FlashCard> cards = [];

  // Load cards from JSON file
  final String jsonString = await rootBundle.loadString('assets/data/flash_cards.json');
  final Map<String, dynamic> jsonData = json.decode(jsonString);

  if (jsonData.containsKey(moduleId)) {
    cards.addAll((jsonData[moduleId] as List)
        .map((item) => FlashCard.fromJson(item))
        .toList());
  }

  // Load cards from SQLite
  final dbCards = await DatabaseHelper.instance.getUserAddedFlashCards(moduleId);
  cards.addAll(dbCards);

  return cards;
}
// custome flash card to database
Future<void> addFlashCard(String moduleId, String question, String answer) async {
  final newCard = FlashCard(question: question, answer: answer);
  await DatabaseHelper.instance.insertFlashCard(newCard, moduleId);
}

Future<int> updateFlashCard(int id, String question, String answer) async {
  final db = await DatabaseHelper.instance.database;
  return await db.update(
    'flashcards',
    {'question': question, 'answer': answer},
    where: 'id = ?',
    whereArgs: [id],
  );
}

Future<int> deleteFlashCard(int id) async {
  final db = await DatabaseHelper.instance.database;
  return await db.delete(
    'flashcards',
    where: 'id = ?',
    whereArgs: [id],
  );
}

Widget buildFlashCardWidget(
    BuildContext context, String question, String answer , ) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(24),
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

      color: themeNotifier.isDarkMode ?Colors.grey.withOpacity(0.03): Colors.grey.shade200,
      borderRadius: BorderRadius.circular(24),
    ),
    child: Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(answer,style: const TextStyle(fontSize: 20),textAlign: TextAlign.center,),
      ),
    ),
  );
}

Widget buildFrontFace(BuildContext context, String question) {
  final themeNotifier = Provider.of<ThemeNotifier>(context);
  return Container(
    decoration: BoxDecoration(
      color: themeNotifier.isDarkMode ? Colors.grey.withOpacity(0.03) : Colors.grey.shade200,
      borderRadius: BorderRadius.circular(24),
    ),
    child: Center(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Text(question,style: const TextStyle(fontSize: 24),textAlign: TextAlign.center,),
    )),
  );
}
