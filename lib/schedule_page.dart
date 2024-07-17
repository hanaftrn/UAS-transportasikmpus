import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/schedule_controller.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key, required this.transportType});

  final String transportType;

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  ScheduleController scheduleController = Get.find<ScheduleController>();
  final List<String> schedules = [
    '08:00 - 08:30',
    '09:00 - 09:30',
    '10:00 - 10:30',
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var isFavorite =
          scheduleController.isFavorite("${widget.transportType} Kampus");

      return Scaffold(
        appBar: AppBar(
          title: Text('${widget.transportType} Schedule'),
          backgroundColor: Colors.lightBlueAccent,
          actions: [
            IconButton(
              onPressed: () async {
                if (isFavorite) {
                  await scheduleController.removeFavorite(
                      {"route": "${widget.transportType} Kampus"});

                  Get.snackbar("Favorite", "Menghapus dari Favorit");
                } else {
                  await scheduleController.addFavorite({
                    'route': "${widget.transportType} Kampus",
                    'type': widget.transportType,
                  });
                  Get.snackbar("Favorite", "Menambahkan ke Favorit");
                }
              },
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Colors.red,
              ),
            )
          ],
        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: schedules.length,
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16.0),
                    title: Text(
                      schedules[index],
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    onTap: () async {
                      try {
                        await scheduleController.addSchedule({
                          'route': "${widget.transportType} Kampus",
                          'tanggal': DateTime.now().toString(),
                          'waktu': schedules[index],
                        });

                        Get.snackbar("Memilih Transportasi",
                            "Anda Memilih ${widget.transportType} pada ${schedules[index]}");
                      } catch (e) {
                        Get.snackbar("Error", e.toString());
                      }
                    },
                  ),
                );
              },
            ),
          ),
        ),
      );
    });
  }
}
