import 'package:flutter/material.dart';

class FooterWidget extends StatelessWidget {
  final VoidCallback
      onAddPressed; // Function to call when the button is pressed

  const FooterWidget({
    super.key,
    required this.onAddPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0), // Padding for the button
      child: ElevatedButton.icon(
        onPressed:
            onAddPressed, // Trigger the function when the button is clicked
        icon: const Icon(Icons.add), // Add icon
        label: const Text('Add'), // Button label
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
              vertical: 12.0, horizontal: 24.0), // Button padding
        ),
      ),
    );
  }
}
