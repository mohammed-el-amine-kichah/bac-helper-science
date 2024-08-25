import 'package:bac_helper_sc/provider/dark_mode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/flash_card.dart';
import '../models/content_type.dart';
import '../screens/lessons_screen.dart';
import 'manage_flash_cards_screen.dart';

class ContentPage extends StatelessWidget {
  final LearningContentType contentType;
  final String moduleName;

  const ContentPage({super.key, required this.contentType, required this.moduleName});

  @override
  Widget build(BuildContext context) {
    if (contentType == LearningContentType.lessons) {
      return const LessonsScreen();
    } else {
      return ScFlashCard(moduleName: moduleName);
    }
  }
}

class ScFlashCard extends StatefulWidget {
  final String moduleName;

  const ScFlashCard({super.key, required this.moduleName});

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
    final bool isDarkMode = Provider.of<ThemeNotifier>(context).isDarkMode;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            child: const Icon(
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
            style: const TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
        body: FutureBuilder<List<FlashCard>>(
          future: loadFlashCards(widget.moduleName),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('خطأ فني بسيط، قم بالابلاغ عن المشكلة'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('لا توجد بطاقات '));
            }

            cards = snapshot.data!;
            return Stack(
              children: [
                Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.45,
                      width: MediaQuery.of(context).size.width * 0.85,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24), // Rounded corners
                        boxShadow: [
                          BoxShadow(
                            color:  isDarkMode ? Colors.grey.withOpacity(0.01): Colors.grey.withOpacity(0.4), // Shadow color
                            spreadRadius: 2, // Spread radius
                            blurRadius: 10, // Blur radius
                            offset: Offset(0, 5), // Offset in the x and y direction
                          ),
                        ],

                      ),
                      child: PageView.builder(
                        controller: controller,
                        physics: const NeverScrollableScrollPhysics(),
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
                        ValueListenableBuilder<int>(
                          valueListenable: currentIndex,
                          builder: (BuildContext context, int value, Widget? child) {
                            return ElevatedButton.icon(
                              onPressed: value > 0
                                  ? () {
                                controller.previousPage(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeInOut);
                              }
                                  : null,
                              icon: const Icon(Icons.arrow_circle_left_rounded),
                              label: const Text(''),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.deepPurple.shade400,
                                  foregroundColor: Colors.white,
                                  fixedSize: const Size(80, 40)),
                            );
                          },
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                        ValueListenableBuilder<int>(
                          valueListenable: currentIndex,
                          builder: (BuildContext context, int value, Widget? child) {
                            return Text(
                              '${value + 1} / ${cards.length}',
                              style: const TextStyle(
                                fontSize: 22,
                              ),
                            );
                          },
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                        ValueListenableBuilder<int>(
                          valueListenable: currentIndex,
                          builder: (BuildContext context, int value, Widget? child) {
                            return ElevatedButton.icon(
                              onPressed: value < cards.length - 1
                                  ? () {
                                controller.nextPage(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeInOut);
                              }
                                  : null,
                              icon: const Icon(Icons.arrow_circle_right_rounded),
                              label: const Text(''),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.deepPurple.shade400,
                                  foregroundColor: Colors.white,
                                  fixedSize: const Size(80, 40)),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ManageFlashCardsScreen(moduleName: widget.moduleName),
                            ),
                          ).then((_) {
                            // Reload flash cards when returning from the manage screen
                            setState(() {
                              loadFlashCards(widget.moduleName).then((newCards) {
                                cards = newCards;
                              });
                            });
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.deepPurple,
                            fixedSize: const Size(200, 60)),
                        child: const Text(
                          'ادارة البطاقات',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
