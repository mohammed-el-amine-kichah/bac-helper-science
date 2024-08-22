import 'package:flutter/material.dart';

class FeatureCardComponent extends StatelessWidget {
  final String imageAsset;
  final String title;
  final VoidCallback onTap;

  const FeatureCardComponent({
    Key? key,
    required this.imageAsset,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Determine if the current theme is dark or light
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: isDarkMode ? Colors.grey[800] : Colors.white, // Change color based on theme
        elevation: 8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 15,),
            AspectRatio(
              aspectRatio: 16 / 11, // Adjust the aspect ratio as needed
              child: Image.asset(
                imageAsset,
                fit: BoxFit.cover, // Adjust as needed
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 16, // Adjust font size if needed
                  color: isDarkMode ? Colors.white : Colors.black, // Change text color based on theme
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
