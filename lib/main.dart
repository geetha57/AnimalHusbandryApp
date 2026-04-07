import 'package:flutter/material.dart';
import 'home.dart';
import 'login.dart';
import 'sign-up.dart';

void main() {
runApp(AnimalHusbandryApp());
}

class AnimalHusbandryApp extends StatelessWidget {
@override
Widget build(BuildContext context) {
return MaterialApp(
title: 'Animal Husbandry',
theme: ThemeData(
primarySwatch: Colors.lightGreen,
),
home: WelcomePage(),
routes: {
'/home': (context) => const HomePage(),
'/login': (context) => LoginPage(),
'/signup': (context) => SignUpPage(),
},
debugShowCheckedModeBanner: false,
);
}
}

class WelcomePage extends StatelessWidget {
@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: Colors.brown[50],
body: Center(
child: Padding(
padding: const EdgeInsets.all(24.0),
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
Icon(Icons.agriculture, size: 100, color: Colors.lightGreen[700]),
SizedBox(height: 30),
Text(
'Welcome to FarmFence',
style: TextStyle(
fontSize: 26,
fontWeight: FontWeight.bold,
color: Colors.green[800],
),
textAlign: TextAlign.center,
),
SizedBox(height: 16),
Text(
'Buy and sell products for livestock care, feed, and more!',
style: TextStyle(fontSize: 16, color: Colors.green[600]),
textAlign: TextAlign.center,
),
SizedBox(height: 40),
ElevatedButton(
onPressed: () {
Navigator.pushNamed(context, '/home');
},
style: ElevatedButton.styleFrom(
backgroundColor: Colors.lightGreenAccent[100],
padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
),
child: Text('Get Started', style: TextStyle(fontSize: 18, color: Colors.black87)),
)
],
),
),
),
);
}
}
