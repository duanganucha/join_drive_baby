import 'package:flutter/material.dart';

class FeedbackScreen extends StatefulWidget {
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  double rating = 0;
  final TextEditingController feedbackController = TextEditingController();

  void _submitFeedback() {
    // Logic to save feedback
    print('Rating: $rating');
    print('Feedback: ${feedbackController.text}');
    // Clear the form
    setState(() {
      rating = 0;
      feedbackController.clear();
    });
    // Navigate back to home screen
    Navigator.pop(context);
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
              items: [1, 2, 3, 4, 5]
                  .map((e) => DropdownMenuItem<double>(
                        child: Text(e.toString()),
                        value: e.toDouble(),
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