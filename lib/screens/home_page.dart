// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _currentFilter = 'Favourites';

  List<Note> _allNotes = [
    Note(
      title: 'Paris Trip',
      content: 'Our trip to Paris was an incredible experience...',
      color: const Color(0xFFE8D5B7),
      date: DateTime(2024, 10, 20),
    ),
    Note(
      title: 'Recipe - Homemade Pizza',
      content: 'Making homemade pizza was a delightful culinary adventure...',
      color: const Color(0xFFE8D5B7),
      date: DateTime(2024, 10, 22),
    ),
    Note(
      title: 'Cardio Workout',
      content: "Today's cardio workout was intense and invigorating...",
      color: const Color(0xFFE6956F),
      date: DateTime.now(),
    ),
  ];

  List<Note> get _filteredNotes {
    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);

    switch (_currentFilter) {
      case 'Today':
        return _allNotes.where((n) {
          final noteDate = DateTime(n.date.year, n.date.month, n.date.day);
          return noteDate.isAtSameMomentAs(todayDate);
        }).toList();
      case 'This week':
        final weekAgo = todayDate.subtract(const Duration(days: 7));
        return _allNotes.where((n) => n.date.isAfter(weekAgo)).toList();
      case 'Last 30 days':
        final monthAgo = todayDate.subtract(const Duration(days: 30));
        return _allNotes.where((n) => n.date.isAfter(monthAgo)).toList();
      default:
        return _allNotes;
    }
  }

  void _addNote(String title, String content) {
    setState(() {
      _allNotes.insert(
        0,
        Note(
          title: title.isEmpty ? 'ملاحظة جديدة' : title,
          content: content,
          color: const Color(0xFFE8D5B7),
          date: DateTime.now(),
        ),
      );
    });
  }

  void _showAddNoteDialog() {
    final titleCtrl = TextEditingController();
    final contentCtrl = TextEditingController();

    Get.dialog(
      AlertDialog(
        title: const Text('إضافة ملاحظة جديدة'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleCtrl,
              decoration: const InputDecoration(
                labelText: 'العنوان',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: contentCtrl,
              decoration: const InputDecoration(
                labelText: 'المحتوى',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('إلغاء')),
          ElevatedButton(
            onPressed: () {
              _addNote(titleCtrl.text, contentCtrl.text);
              Get.back();
            },
            child: const Text('إضافة'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: EdgeInsets.all(w * 0.04),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'My Notes',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () => Get.to(() => SettingsPage()),
                    child: const Icon(Icons.more_horiz, size: 28),
                  ),
                ],
              ),
            ),

            // Filter Chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: w * 0.04),
              child: Row(
                children: [
                  _buildFilterChip('Favourites'),
                  SizedBox(width: w * 0.02),
                  _buildFilterChip('Today'),
                  SizedBox(width: w * 0.02),
                  _buildFilterChip('This week'),
                  SizedBox(width: w * 0.02),
                  _buildFilterChip('Last 30 days'),
                ],
              ),
            ),

            SizedBox(height: h * 0.02),

            // Notes List
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: w * 0.04),
                itemCount: _filteredNotes.length,
                itemBuilder: (ctx, idx) {
                  final note = _filteredNotes[idx];
                  return NoteCard(
                    note: note,
                    onEdit: () async {
                      final updatedNote = await Get.toNamed(
                        '/edit',
                        arguments: note,
                      );
                      if (updatedNote != null && updatedNote is Note) {
                        setState(() {
                          final i = _allNotes.indexOf(note);
                          _allNotes[i] = updatedNote;
                        });
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddNoteDialog,
        backgroundColor: Colors.black,
        child: Icon(Icons.add, color: Colors.white, size: 32),
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final selected = _currentFilter == label;
    return GestureDetector(
      onTap: () => setState(() => _currentFilter = label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: selected ? Colors.black : Colors.white,
          border: Border.all(color: selected ? Colors.black : Colors.grey),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : Colors.grey[700],
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

class NoteCard extends StatelessWidget {
  final Note note;
  final VoidCallback onEdit;

  const NoteCard({required this.note, required this.onEdit, super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(bottom: w * 0.04),
      padding: EdgeInsets.all(w * 0.04),
      decoration: BoxDecoration(
        color: note.color,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  note.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              GestureDetector(
                onTap: onEdit,
                child: const Icon(Icons.edit, size: 24),
              ),
            ],
          ),
          SizedBox(height: w * 0.02),
          Text(note.content, style: const TextStyle(fontSize: 16, height: 1.5)),
        ],
      ),
    );
  }
}

class Note {
  String title;
  String content;
  Color color;
  DateTime date;

  Note({
    required this.title,
    required this.content,
    required this.color,
    required this.date,
  });
}
