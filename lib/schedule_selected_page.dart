import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/schedule_controller.dart';

class ScheduleSelected extends StatefulWidget {
  const ScheduleSelected({super.key});

  @override
  State<ScheduleSelected> createState() => _ScheduleSelectedState();
}

class _ScheduleSelectedState extends State<ScheduleSelected> {
  final schedule = Get.find<ScheduleController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule Selected'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Container(
        child: Obx(() {
          if (schedule.schedules.isEmpty) {
            return const Center(
              child: Text(
                'No Schedule Selected',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueGrey),
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: schedule.schedules.length,
              itemBuilder: (context, index) {
                final selectedSchedule = schedule.schedules[index];

                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16.0),
                    title: Text(
                      selectedSchedule['route'] ?? '',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      selectedSchedule['waktu'] ?? '',
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.grey),
                      onPressed: () async {
                        try {
                          await schedule.removeSchedule(selectedSchedule);
                        } catch (e) {
                          log('Error Delete Schedule ${e.toString()}');
                        }
                      },
                    ),
                  ),
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
