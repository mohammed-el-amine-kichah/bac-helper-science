import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/dark_mode.dart';

class Subject {
  final String name;
  final int weight;
  final bool optional;

  Subject({required this.name, required this.weight, this.optional = false});
}

class AverageCalculator extends StatefulWidget {
  const AverageCalculator({super.key});

  @override
  State<AverageCalculator> createState() => _AverageCalculatorState();
}

class _AverageCalculatorState extends State<AverageCalculator> {
  final _formKey = GlobalKey<FormState>();
  final List<Subject> _subjects = [
    Subject(name: 'الرياضيات', weight: 5),
    Subject(name: 'علوم الطبيعة والحياة', weight: 6),
    Subject(name: 'العلوم الفزيائية', weight: 5),
    Subject(name: 'اللغة العربية', weight: 3),
    Subject(name: 'اللغة الفرنسية', weight: 2),
    Subject(name: 'اللغة الانجليزية', weight: 2),
    Subject(name: 'الاجتماعيات', weight: 2),
    Subject(name: 'العلوم الاسلامية', weight: 2),
    Subject(name: 'الفلسفة', weight: 2),
    Subject(name: 'اللغة الأمازيغية', weight: 2, optional: true),
    Subject(name: 'التربية البدنية', weight: 1, optional: true),
  ];

  late Map<String, TextEditingController> _markControllers;

  @override
  void initState() {
    super.initState();
    _markControllers = {
      for (var subject in _subjects) subject.name: TextEditingController(),
    };
  }

  @override
  void dispose() {
    for (var controller in _markControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  double calculateAverage() {
    double totalWeightedMarks = 0;
    double totalWeights = 0;

    for (var subject in _subjects) {
      double mark = double.tryParse(_markControllers[subject.name]?.text ?? '') ?? 0;
      if (subject.optional && mark == 0) continue;

      totalWeightedMarks += mark * subject.weight;
      totalWeights += subject.weight;
    }

    return totalWeights > 0 ? totalWeightedMarks / totalWeights : 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'حساب المعدل',
          style: TextStyle(color: Colors.white, fontSize: 20),
          textDirection: TextDirection.rtl,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Consumer<ThemeNotifier>(
          builder: (context, themeNotifier, child) {
            return Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  children: [
                    ..._subjects.map((subject) => _buildSubjectField(subject)),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _calculateAndShowResult,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.deepPurple,
                        fixedSize: Size(MediaQuery.of(context).size.width * 0.7, 60),
                      ),
                      child: const Text(
                        'حساب المعدل',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
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

  Widget _buildSubjectField(Subject subject) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: TextFormField(
        controller: _markControllers[subject.name],
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          filled: true,
          label: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Text(
                  subject.optional ? '${subject.name} (اختياري)' : subject.name,
                  style: TextStyle(
                    color: themeNotifier.isDarkMode ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          helperText: 'المعامل: ${subject.weight}',
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide(
              color: themeNotifier.isDarkMode ? Colors.blueAccent : Colors.grey.shade300,
              width: 2,
            ),
          ),
          border: OutlineInputBorder(
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
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        validator: (value) {
          if (value == null || value.isEmpty) {
            if (!subject.optional) {
              return 'الرجاء إدخال العلامة';
            }
            return null; // Allow empty field for optional subjects
          }
          double? num = double.tryParse(value);
          if (num == null || num < 0 || num > 20) {
            return 'الرجاء إدخال رقم صحيح (0-20)';
          }
          return null;
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: (value) {
          // This will trigger validation every time the field changes
          Form.of(context).validate();
        },
      ),
    );
  }

  void _calculateAndShowResult() {
    if (_formKey.currentState!.validate()) {
      double average = calculateAverage();
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Center(child: Text(average > 10 ? 'ناجح' : 'راسب')),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('المعدل النهائي هو: ${average.toStringAsFixed(2)}'),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(MediaQuery.of(context).size.width * 0.3, 30),
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('موافق'),
                ),
              ],
            ),
          ],
        ),
      );
    }
  }
}
