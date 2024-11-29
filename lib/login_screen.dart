import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'main.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();

    // Get screen width and height
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight * 0.1), // Adjust top space based on screen height
              
              // Username TextField
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
              ),
              
              SizedBox(height: screenHeight * 0.03), // Space between inputs

              // Password TextField
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),

              SizedBox(height: screenHeight * 0.05), // Space before the button

              // Log In Button
              SizedBox(
                width: screenWidth * 0.8, // Adjust button width
                child: ElevatedButton(
                  onPressed: () {
                    final username = usernameController.text;
                    final password = passwordController.text;
                    if (username.isNotEmpty && password.isNotEmpty) {
                      ref.read(isLoggedInProvider.notifier).state = true;
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please enter both username and password.')),
                      );
                    }
                  },
                  child: Text(
                    'Log In',
                    style: TextStyle(fontSize: screenWidth * 0.05), // Adjust button text size
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
