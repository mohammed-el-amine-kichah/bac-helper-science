import 'package:flutter/material.dart';
import '../components/flash_card.dart';
import '../models/content_type.dart';
import '../screens/lessons_screen.dart';


class ContentPage extends StatelessWidget {
  final LearningContentType contentType;
  final String moduleName;

  ContentPage({required this.contentType, required this.moduleName});

  @override
  Widget build(BuildContext context) {
    if (contentType == LearningContentType.lessons) {
      return LessonsScreen();
    } else {
      return ScFlashCard(moduleName: moduleName);
    }
  }
}

class ScFlashCard extends StatefulWidget {
  final String moduleName;

  const ScFlashCard({Key? key, required this.moduleName}) : super(key: key);

  @override
  _ScFlashCardState createState() => _ScFlashCardState();
}

class _ScFlashCardState extends State<ScFlashCard> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.4,
            child: buildCardList(context, widget.moduleName),
          ),
        ),
      ),
    );
  }
}