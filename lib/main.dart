import 'package:flutter/material.dart';
import 'pages/packages_page.dart';
import 'pages/payment_page.dart';
import 'pages/review_page.dart';
import 'pages/user_details_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/packages': (context) => PackagesPage(),
        '/payment': (context) => PaymentPage(
              packageName: 'Basic Package',
              packagePrice: 100,
            ),
        '/review': (context) => ReviewPage(),
        '/user-details': (context) => UserDetailsPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Set a background image for the body
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/wallpaper.jpg'), // Background image
            fit: BoxFit.cover, // Ensure the image covers the entire screen
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Title above the ElevatedButton
              Text(
                'Welcome to Our Beauty Salon', // Add your title here
                style: TextStyle(
                  fontSize: 24, // Title size
                  fontWeight: FontWeight.bold, // Bold text
                  color: Colors.white, // White text color for contrast
                  shadows: [
                    Shadow(blurRadius: 10.0, color: Colors.black, offset: Offset(2.0, 2.0)), // Optional shadow for better visibility
                  ],
                ),
              ),
              SizedBox(height: 30), // Add space between the title and the button
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/user-details');
                },
                child: Text('SET YOUR BOOKING NOW!!'),
                style: ElevatedButton.styleFrom(
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
