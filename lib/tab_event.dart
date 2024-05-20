import 'package:event_kampus/detail_event.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TabEvent extends StatelessWidget {
 
  Box? _daftarEvent;
  Widget build(BuildContext context) {

    List<Map<String, dynamic>> events = [
      {"judul": "Event 1", "tanggal": "19 Mei 2024", "jam": "19.00", "deskripsi": "Deskripsi event 1"},
      {"judul": "Event 2", "tanggal": "25 Mei 2024", "jam": "16.00", "deskripsi": "Deskripsi event 2"},
    ];
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Cari Berdasarkan Kategori',
                      suffixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.date_range_outlined),
                  onPressed: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                  },
                  tooltip: 'Select Date',
                ),
              ],
            ),
            SizedBox(height: 16),
            Text("Daftar Event",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: events.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildEventCard(context, events[index]);
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildEventCard(BuildContext context, Map<String, dynamic> eventData) {
    if (_daftarEvent == null){
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Detail Event"),
              content: DetailEvent(eventData), // Widget dari detail_event.dart
              actions: <Widget>[
                ElevatedButton(
                  child: Text("Daftar"),
                  onPressed: () {
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white
                  ),
                ),
                ElevatedButton(
                  child: Text("Close"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white
                  ),
                ),
              ],
            );
          },
        );
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8),
        elevation: 4,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                eventData['judul'],
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                eventData['tanggal'],
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: 8),
              Text(
                eventData['jam'],
                style: TextStyle(fontSize: 14),
              )
            ],
          ),
        ),
      ),
    );
  }
}
