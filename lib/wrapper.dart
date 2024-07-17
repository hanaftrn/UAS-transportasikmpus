import 'package:apk_kampus/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_page.dart';
import 'controllers/schedule_controller.dart';
import 'services/auth_service.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  final ScheduleController _scheduleRoutes = Get.find<ScheduleController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        initialData: AuthService().currentUser,
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _scheduleRoutes.initSchedule();
            return const AppPage();
          } else {
            _scheduleRoutes.closeSchedule();
            return LoginPage();
          }
        },
      ),
    );
  }
}
