import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FeatureCardComponent extends StatelessWidget {
  final String imageAsset;
  final String title;
  final VoidCallback onTap;

  const FeatureCardComponent({
    super.key,
    required this.imageAsset,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Determine if the current theme is dark or light
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Stack(

        children: [
          Card(
            color: isDarkMode ? Colors.grey[800] : Colors.white, // Change color based on theme
            elevation: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 10,),
                AspectRatio(
                  aspectRatio: 16 / 10, // Adjust the aspect ratio as needed
                  child: SvgPicture.asset(
                    imageAsset,
                    fit: BoxFit.contain, // Adjust as needed
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
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
          ),
        ]

      ),
    );
  }
}
