import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }

  List<String> scopes = <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ];

  @override
  void initState() {
    checkAuthen();

    super.initState();
  }

  checkAuthen() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // checkAuthen();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
              controller: emailController,
              hintText: 'Email',
              obscureText: false,
            ),
            const SizedBox(height: 16.0),
            CustomTextField(
              controller: passwordController,
              hintText: 'Password',
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            CustomButton(
              text: 'Login',
              onPressed: () {
                // Handle login logic
                Navigator.pushReplacementNamed(context, '/home');
              },
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: const Text('Don\'t have an account? Register'),
            ),
            ElevatedButton(
                onPressed: () {
                  onSignWithGoogle();
                },
                child: Text("SignIn with Google"))
          ],
        ),
      ),
    );
  }

  void onSignWithGoogle() async {
    // GoogleSignIn _googleSignIn = GoogleSignIn(
    //   // Optional clientId
    //   clientId: '557735717171-n7vfprstqo0n2ljvv5o386um4serv9ml.apps.googleusercontent.com',
    //   scopes: scopes,
    // );
    //   try {
    //     await _googleSignIn.signIn();
    //   } catch (error) {
    //     print(error);
    //   }
  }
}
