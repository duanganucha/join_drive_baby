import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:join_drive_baby/screens/map_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late FirebaseMessaging _firebaseMessaging;

  @override
  void initState() {
    super.initState();
    _firebaseMessaging = FirebaseMessaging.instance;

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text(notification.title ?? ''),
              content: Text(notification.body ?? ''),
            );
          },
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      Navigator.pushNamed(context, '/notification');
    });

    _firebaseMessaging.subscribeToTopic('teachers');
  }

  final List<Map<String, dynamic>> users = [
    {'name': 'User 1', 'location': 'Location 1'},
    {'name': 'User 2', 'location': 'Location 2'},
    {'name': 'User 3', 'location': 'Location 3'},
  ];

  void sendNotification(String title, String message) async {
    final postUrl = 'https://fcm.googleapis.com/fcm/send';
    final data = {
      "to": "/topics/teachers",
      "notification": {
        "title": title,
        "body": message,
      },
    };

    final headers = {
      'content-type': 'application/json',
      'Authorization': 'key=BBpWApZC2jKnHgQXPgebdZdfubh3_m3FvhYZHYKMQKi7d6yppeTl1CedvEmCLhIqYeGZQr4Ec4GC8AgE-T0ifFY ', 
    };

    final response = await http.post(
      Uri.parse(postUrl),
      body: json.encode(data),
      headers: headers,
    );

    if (response.statusCode == 200) {
      print('Notification sent successfully');
    } else {
      print('Failed to send notification');
    }
  }

  void navigateToMap(Map<String, dynamic> user) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapScreen(user: user),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(users[index]['name']),
                  subtitle: Text(users[index]['location']),
                  trailing: IconButton(
                    icon: Icon(Icons.location_on),
                    onPressed: () {
                      navigateToMap(users[index]);
                      sendNotification(
                        'Parent Arrival',
                        'A parent has arrived to pick up ${users[index]['name']}',
                      );
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/feedback');
              },
              child: Text('Give Feedback'),
            ),
          ),
        ],
      ),
    );
  }
}