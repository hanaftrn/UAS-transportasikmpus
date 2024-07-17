import 'package:apk_kampus/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/schedule_controller.dart';
import 'favorite_page.dart';
import 'home_page.dart';
import 'search_page.dart';
import 'profile_page.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Get.put(ScheduleController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Aplikasi Transportasi Kampus',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Wrapper(),
        '/home': (context) => const HomePage(),
        '/search': (context) => const SearchPage(),
        '/profile': (context) => const ProfilePage(),
        '/favorites': (context) => const FavoritePage(),
      },
    );
  }
}
