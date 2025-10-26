import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_page.dart';

class EditNotePage extends StatefulWidget {
  const EditNotePage({super.key});

  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  late TextEditingController _titleCtrl;
  late TextEditingController _contentCtrl;
  late Note _currentNote;
  late Color _selectedColor;

  final List<Color> _colors = [
    const Color(0xFFE8D5B7),
    const Color(0xFFE6956F),
    const Color(0xFFADD19E),
    const Color(0xFFB4C7E7),
    const Color(0xFFE8B4D9),
  ];

  @override
  void initState() {
    super.initState();
    _currentNote = Get.arguments;
    _titleCtrl = TextEditingController(text: _currentNote.title);
    _contentCtrl = TextEditingController(text: _currentNote.content);
    _selectedColor = _currentNote.color;
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _contentCtrl.dispose();
    super.dispose();
  }

  void _saveNote() {
    if (_titleCtrl.text.trim().isEmpty) {
      Get.snackbar(
        'تنبيه',
        'يرجى إدخال عنوان الملاحظة',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[900],
      );
      return;
    }

    final updatedNote = Note(
      title: _titleCtrl.text.trim(),
      content: _contentCtrl.text.trim(),
      color: _selectedColor,
      date: DateTime.now(),
    );
    Get.back(result: updatedNote);
  }

  void _openOptionsMenu() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'خيارات الملاحظة',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'اختر لون الخلفية',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              children: _colors.map((c) {
                final selected = c == _selectedColor;
                return GestureDetector(
                  onTap: () {
                    setState(() => _selectedColor = c);
                    Get.back();
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: c,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: selected ? Colors.black : Colors.transparent,
                        width: 3,
                      ),
                    ),
                    child: selected
                        ? const Icon(Icons.check, color: Colors.black)
                        : null,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('مشاركة الملاحظة'),
              onTap: () => Get.back(),
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text(
                'حذف الملاحظة',
                style: TextStyle(color: Colors.red),
              ),
              onTap: _confirmDelete,
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  void _confirmDelete() {
    Get.dialog(
      AlertDialog(
        title: const Text('تأكيد الحذف'),
        content: const Text('هل أنت متأكد من حذف هذه الملاحظة؟'),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('إلغاء')),
          ElevatedButton(
            onPressed: () {
              Get.back();
              Get.back(result: 'delete');
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('حذف'),
          ),
        ],
      ),
    );
  }

  Widget _toolbarButton(IconData icon) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 22),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _selectedColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.arrow_back),
                    ),
                  ),
                  GestureDetector(
                    onTap: _openOptionsMenu,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.more_horiz),
                    ),
                  ),
                ],
              ),
            ),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _toolbarButton(Icons.format_align_left),
                    _toolbarButton(Icons.format_align_center),
                    _toolbarButton(Icons.format_align_right),
                    _toolbarButton(Icons.format_bold),
                    _toolbarButton(Icons.format_italic),
                    _toolbarButton(Icons.format_underline),
                    _toolbarButton(Icons.format_color_text),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _titleCtrl,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'عنوان الملاحظة',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                      maxLines: null,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _contentCtrl,
                      style: const TextStyle(fontSize: 17, height: 1.6),
                      decoration: const InputDecoration(
                        hintText: 'ابدأ الكتابة...',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: _saveNote,
        backgroundColor: Colors.black,
        icon: const Icon(Icons.save, color: Colors.white),
        label: const Text(
          'حفظ',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
