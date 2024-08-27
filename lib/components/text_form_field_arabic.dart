
import 'package:bac_helper_sc/provider/dark_mode.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class ArabicFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String title;
  final int minLines;
  final int maxLines;
  final String? Function(String?)? validator;

  const ArabicFormField({
    super.key,
    required this.controller,
    required this.keyboardType,
    required this.title,
    this.minLines = 1,
    this.maxLines = 1,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return TextFormField(
      maxLines: maxLines,
      minLines: minLines,
      controller: controller ,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        alignLabelWithHint: true,
        label: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Text(
                title,
                style: TextStyle(
                  color: themeNotifier.isDarkMode ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),


        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),

        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide(
            color: themeNotifier.isDarkMode ? Colors.red.shade300 : Colors.red,
          ),
        ),

      ),
      keyboardType: keyboardType,
      validator: validator,

      );

  }
}

