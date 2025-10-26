import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/editnotepage.dart';
import 'screens/settings_page.dart';
import 'screens/home_page.dart';
import 'screens/signup_page.dart';
import 'screens/welcome_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notes App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/welcome',
      getPages: [
        GetPage(name: '/welcome', page: () => const WelcomePage()),
        GetPage(name: '/signup', page: () => const SignUpPage()),
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/edit', page: () => const EditNotePage()),
        GetPage(name: '/settings', page: () => SettingsPage()),
      ],
    );
  }
}
