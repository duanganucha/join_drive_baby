import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';
import 'screens/map_screen.dart';
import 'screens/feedback_screen.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyCx5VoLD55G2lCbXM1yef2U2qcaHJujDJo",
          authDomain: "data-c13d3.firebaseapp.com",
          databaseURL: "https://data-c13d3-default-rtdb.firebaseio.com",
          projectId: "data-c13d3",
          storageBucket: "data-c13d3.appspot.com",
          messagingSenderId: "557735717171",
          appId: "1:557735717171:web:46f3f02c7bba56911a7646",
          measurementId: "G-W519Y4NTNW"));
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ride Sharing App',
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/home': (context) => HomeScreen(),
        '/map': (context) => MapScreen(user: {'id': '123', 'name': 'John Doe'}),
        '/feedback': (context) => FeedbackScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/map') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) {
              return MapScreen(user: args['user']);
            },
          );
        }
        return null;
      },
    );
  }
}
