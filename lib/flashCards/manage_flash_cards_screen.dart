import 'dart:async';

import 'package:bac_helper_sc/provider/dark_mode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../components/flash_card.dart';
import '../components/text_form_field_arabic.dart';
import '../models/database_helper.dart';

class ManageFlashCardsScreen extends StatefulWidget {
  final String moduleName;

  const ManageFlashCardsScreen({super.key, required this.moduleName});

  @override
  _ManageFlashCardsScreenState createState() => _ManageFlashCardsScreenState();
}

class _ManageFlashCardsScreenState extends State<ManageFlashCardsScreen> {
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _answerController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController(); // To control scrolling
  List<FlashCard> cards = [];
  bool showSuccessMessage = false;
  FlashCard? _editingCard;// Track which card is being edited

  @override
  void initState() {
    super.initState();
    _loadCards();
  }

  Future<void> _loadCards() async {
    final loadedCards = await DatabaseHelper.instance.getUserAddedFlashCards(widget.moduleName);
    setState(() {
      cards = loadedCards;
    });
  }
  void _showSuccessMessage() {
    setState(() {
      showSuccessMessage = true; // Show the success message container
    });

    // Hide the container after 1 second
    Timer(const Duration(milliseconds: 2700), () {
      setState(() {
        showSuccessMessage = false; // Hide the success message container
      });
    });
  }

  Future<void> _addOrEditCard() async {

    if (_formKey.currentState?.validate() ?? false) {

      if (_editingCard != null) {


        // Edit mode
        await DatabaseHelper.instance.updateFlashCard(
          _editingCard!.id,
          _questionController.text,
          _answerController.text,
        );
        _showSuccessMessage();
        setState(() {
          _editingCard = null; // Reset editing card
        });
      } else {
        // Add mode

        final newCard = FlashCard(
          question: _questionController.text,
          answer: _answerController.text,
        );
        await DatabaseHelper.instance.insertFlashCard(newCard, widget.moduleName);
        _showSuccessMessage();
        // Clear the controllers
        _questionController.clear();
        _answerController.clear();
      }
      await _loadCards();
    }
  }

  void _editCard(FlashCard card) {
    setState(() {
      _editingCard = card;
      _questionController.text = card.question;
      _answerController.text = card.answer;
    });

    // Scroll to the form when editing is started
    _scrollController.animateTo(
      _scrollController.position.minScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _deleteCard(int id) async {
    await DatabaseHelper.instance.deleteFlashCard(id);
    _scrollController.animateTo(
      _scrollController.position.minScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    _showSuccessMessage();
    await _loadCards();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Provider.of<ThemeNotifier>(context).isDarkMode;
    return Scaffold(
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
        title: const Text('اعدادات بطاقات المراجعة', style: TextStyle(color: Colors.white, fontSize: 18)),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                if (showSuccessMessage)
                  Center(
                    child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width * 0.8,
                      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFFC7DFC4),
                          width: 1,
                        ),
                        color: const Color(0xFFE2F5E1),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1), // Shadow color
                            spreadRadius: 2, // How much the shadow spreads
                            blurRadius: 10, // How blurred the shadow is
                            offset: const Offset(0, 4), // Shadow position (x, y)
                          ),
                        ],
                      ),

              child:
                          Row(
                            children: [
                              Image.asset('assets/images/success_icon.png'),
                              const Spacer(),
                              const Text(
                                'تمت العملية بنجاح',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  color: Color(0xFF407C3D),
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          )

                    ). animate()
                        .shimmer(delay : 200.ms, duration: 1800.ms)
                        .shake(hz:3, curve: Curves.easeInOutCubic)
                        .scaleXY(end: 1.1, duration: 600.ms)
                        .then(delay: 600.ms)
                        .scaleXY(end: 1/1.1),
                  ),
                  const SizedBox(height: 20,),

                ArabicFormField(
                  minLines: 2,
                  maxLines: 5,
                  controller: _questionController,
                  keyboardType: TextInputType.text,
                  title: 'السؤال',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'هذا الحقل مطلوب';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                ArabicFormField(
                  minLines: 3,
                  maxLines: 9,
                  controller: _answerController,
                  keyboardType: TextInputType.text,
                  title: 'الجواب',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'هذا الحقل مطلوب';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: (){
                 _addOrEditCard();
                    },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    fixedSize: const Size(160,50)
                  ),
                  child: Text(_editingCard != null ? 'تعديل البطاقة' : 'اضافة بطاقة',style: const TextStyle(fontSize: 20),),
                ),
                const SizedBox(height: 32),
                const Text('البطاقات الحالية',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),

                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: cards.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(cards[index].question,textAlign: isArabic(cards[index].question) ? TextAlign.end : TextAlign.start,),
                        subtitle: Text(cards[index].answer,style:TextStyle(color:  isDarkMode ?   Colors.white : Colors.black ),textAlign: isArabic(cards[index].answer) ? TextAlign.end : TextAlign.start,),
                        leading:
                        isArabic(cards[index].question) ?
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [

                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                _deleteCard(cards[index].id!);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => _editCard(cards[index]),
                            ),
                          ],
                        ) : null,
                        trailing:
                        ! isArabic(cards[index].question) ?
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [

                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                _deleteCard(cards[index].id!);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => _editCard(cards[index]),
                            ),
                          ],
                        ) : null,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

bool isArabic(String text) {
  final arabicRegex = RegExp(r'[\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF]');
  return arabicRegex.hasMatch(text);
}
