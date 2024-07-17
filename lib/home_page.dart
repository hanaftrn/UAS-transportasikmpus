import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'profile_page.dart';
import 'search_page.dart';
import 'services/notification_service.dart';
import 'schedule_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _navigateToSchedule(String transportType) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SchedulePage(transportType: transportType),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aplikasi Transportasi Kampus'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                _navigateToSchedule('Bus');
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/bus.png',
                    width: 24,
                    height: 24,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 8),
                  const Text('Bus Kampus'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _navigateToSchedule('Van');
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/van.png',
                    width: 24,
                    height: 24,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 8),
                  const Text('Van Kampus'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _navigateToSchedule('Sepeda');
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/sepeda.png',
                    width: 24,
                    height: 24,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 8),
                  const Text('Sepeda Kampus'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/favorites');
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.favorite),
                  SizedBox(width: 8),
                  Text('Favorite'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
