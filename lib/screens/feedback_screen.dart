import 'package:flutter/material.dart';

class FeedbackScreen extends StatefulWidget {
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  double rating = 1.0; // Set a default rating within the valid range
  final TextEditingController feedbackController = TextEditingController();

  void _submitFeedback() {
    if (feedbackController.text.isEmpty) {
      // Show an error message or a SnackBar if the feedback is empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please provide your feedback.')),
      );
      return;
    }

    // Logic to save feedback
    print('Rating: $rating');
    print('Feedback: ${feedbackController.text}');

    // Clear the form
    setState(() {
      rating = 1.0;
      feedbackController.clear();
    });

    // Optionally, show a confirmation dialog before navigating back
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Thank you!'),
        content: Text('Your feedback has been submitted.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Close the dialog
            child: Text('OK'),
          ),
        ],
      ),
    ).then((_) {
      // Navigate back to the previous screen after the dialog is closed
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Please rate your experience with the app'),
            SizedBox(height: 20),
            DropdownButton<double>(
              value: rating,
              items: [1.0, 2.0, 3.0, 4.0, 5.0]
                  .map((e) => DropdownMenuItem<double>(
                        value: e,
                        child: Text(e.toString()),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  rating = value!;
                });
              },
            ),
            SizedBox(height: 20),
            TextField(
              controller: feedbackController,
              decoration: InputDecoration(
                hintText: 'Enter your feedback here',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitFeedback,
              child: Text('Submit Feedback'),
            ),
          ],
        ),
      ),
    );
  }
}
