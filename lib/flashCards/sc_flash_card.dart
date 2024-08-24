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
  ValueNotifier<int> currentIndex = ValueNotifier<int>(0); // Current index of the flashcard
  List<FlashCard> cards = [];
  late final PageController controller = PageController();

  @override
  void dispose() {
    controller.dispose();
    currentIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
          title: Text(
            widget.moduleName,
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
        body: FutureBuilder<List<FlashCard>>(
          future: loadFlashCards(widget.moduleName),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No flash cards available'));
            }

            cards = snapshot.data!;
            return Center(
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text(
                          'اضافة بطاقة',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blueAccent,
                            fixedSize: Size(200, 60)),
                      )
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                  Container(
                    height: 300,
                    width: 300,
                    child: PageView.builder(
                      controller: controller,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: cards.length,
                      onPageChanged: (index) {
                        currentIndex.value = index;
                      },
                      itemBuilder: (context, index) {
                        return buildFlashCardWidget(
                          context,
                          cards[index].question,
                          cards[index].answer,
                        );
                      },
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed:
                             () {
                          controller.previousPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut);
                        },
                        icon:  Icon(Icons.arrow_circle_left_rounded),
                        label: Text(''),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            foregroundColor: Colors.white,
                            fixedSize: Size(80, 40)),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                      ValueListenableBuilder<int>(
                        valueListenable: currentIndex,
                        builder: (BuildContext context, int value, Widget? child) {
                          return Text('${value + 1} / ${cards.length}');
                        },
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                      ElevatedButton.icon(
                        onPressed: currentIndex.value < cards.length - 1
                            ? () {
                          controller.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut);
                        }
                            : null,
                        icon: Icon(Icons.arrow_circle_right_rounded),
                        label: Text(''),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            foregroundColor: Colors.white,
                            fixedSize: Size(80, 40)),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }


}
