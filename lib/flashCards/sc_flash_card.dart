import 'package:bac_helper_sc/provider/dark_mode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    final themeNotifier = Provider.of<ThemeNotifier>(context);
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
            return SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            showDialog(context: context,
                              builder: (BuildContext context) => AlertDialog(
                                content: SizedBox(
                                  height: 430,
                                  child: Center(
                                      child: Column(
                                        children: [
                                          TextFormField(
                                            maxLines: 5,
                                            textAlign: TextAlign.center,
                                            decoration: InputDecoration(
                                              filled: true,
                                              label: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                                                    child: Text(
                                                      'السؤال',
                                                      style: TextStyle(
                                                        color: themeNotifier.isDarkMode ? Colors.white : Colors.black,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(24),
                                                borderSide: BorderSide(
                                                  color: themeNotifier.isDarkMode ? Colors.blueAccent : Colors.grey.shade300,
                                                  width: 2,
                                                ),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(24),
                                                borderSide: BorderSide(
                                                  color: themeNotifier.isDarkMode ? Colors.redAccent : Colors.red,
                                                ),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(24),
                                                borderSide: BorderSide(
                                                  color: themeNotifier.isDarkMode ? Colors.blueAccent : Colors.grey.shade300,
                                                ),
                                              ),
                                            ),
                                            keyboardType: TextInputType.text,
                                            validator: (value) {
                                              if (value == null || value.isEmpty)
                                                  return 'الرجاء ادخال السؤال ';
                                              return null;
                                            },
                                            autovalidateMode: AutovalidateMode.onUserInteraction,
                                            onChanged: (value) {
                                              // This will trigger validation every time the field changes
                                              Form.of(context).validate();
                                            },
                                          ),
                                          const SizedBox(height: 15,),
                                          TextFormField(
                                            maxLines: 7,
                                            textAlign: TextAlign.center,
                                            decoration: InputDecoration(
                                              filled: true,
                                              label: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                                                    child: Text(
                                                      'الجواب',
                                                      style: TextStyle(
                                                        color: themeNotifier.isDarkMode ? Colors.white : Colors.black,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(24),
                                                borderSide: BorderSide(
                                                  color: themeNotifier.isDarkMode ? Colors.blueAccent : Colors.grey.shade300,
                                                  width: 2,
                                                ),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(24),
                                                borderSide: BorderSide(
                                                  color: themeNotifier.isDarkMode ? Colors.redAccent : Colors.red,
                                                ),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(24),
                                                borderSide: BorderSide(
                                                  color: themeNotifier.isDarkMode ? Colors.blueAccent : Colors.grey.shade300,
                                                ),
                                              ),
                                            ),
                                            keyboardType: TextInputType.text,
                                            validator: (value) {
                                              if (value == null || value.isEmpty)
                                                return 'الرجاء ادخال الجواب ';
                                              return null;
                                            },
                                            autovalidateMode: AutovalidateMode.onUserInteraction,
                                            onChanged: (value) {
                                              // This will trigger validation every time the field changes
                                              Form.of(context).validate();
                                            },
                                          ),
                                          const SizedBox(height: 15,),
                                          Row(
                                            children: [
                                              ElevatedButton(onPressed: () {},
                                                  child: Text('تأكيد'),
                                                style: ElevatedButton.styleFrom(
                                                  fixedSize: Size(80, 40),
                                                  backgroundColor: Colors.deepPurple,
                                                  foregroundColor: Colors.white,
                                                ),
                                              ),
                                              const SizedBox(width: 10,),
                                              ElevatedButton(onPressed: () {
                                                Navigator.pop(context);
                                              },
                                                child: Text('الغاء'),
                                                style: ElevatedButton.styleFrom(
                                                  fixedSize: Size(80, 40),
                                                  backgroundColor: Colors.grey.shade200,
                                                  foregroundColor: Colors.black,
                                                ),
                                              )
                                            ],
                                          ),

                                        ],
                                      ),
                                    ),
                                ),
                                ),
                            );
                          },
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
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width * 0.8 ,
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
                            return Text('${value + 1} / ${cards.length}',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),);
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
              ),
            );
          },
        ),
      ),
    );
  }


}
