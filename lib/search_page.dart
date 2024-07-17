import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final List<String> _allSchedules = [
    'Bus - 08:00 - 08:30',
    'Bus - 09:00 - 09:30',
    'Van - 10:00 - 10:30',
    'Sepeda - 11:00 - 11:30',
  ];

  List<String> _filteredSchedules = [];
  final TextEditingController _searchController = TextEditingController();
  int _selectedIndex = 1; // Index for Search Page

  @override
  void initState() {
    super.initState();
    _filteredSchedules = _allSchedules;
  }

  void _filterSchedules(String query) {
    List<String> filtered = _allSchedules
        .where(
            (schedule) => schedule.toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() {
      _filteredSchedules = filtered;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        Navigator.pushNamed(context, '/home'); // Navigate to Home
      } else if (index == 2) {
        Navigator.pushNamed(context, '/profile'); // Navigate to Profile
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pencarian Transportasi'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Cari Transportasi',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    _filterSchedules('');
                  },
                ),
              ),
              onChanged: (value) {
                _filterSchedules(value);
              },
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredSchedules.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_filteredSchedules[index]),
                    onTap: () {
                      // Tambahkan logika untuk menampilkan detail jadwal
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
