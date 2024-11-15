import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intermediate_mobile_amcc24/shared/themes/theme.dart';

class DetailNotePage extends StatelessWidget {
  final Map<String, dynamic> note;
  final Function onUpdate;

  const DetailNotePage({Key? key, required this.note, required this.onUpdate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = TextEditingController(text: note['title']);
    final TextEditingController contentController = TextEditingController(text: note['content']);

    Future<void> deleteNote() async {
      await FirebaseFirestore.instance
          .collection('notes')
          .doc(note['id'])
          .delete();
      onUpdate(); // Refresh notes list in the previous screen
      Navigator.pop(context); // Go back to the previous screen
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'Edit Note',
          style: whiteColorTextStyle,
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.save,
              color: whiteColor,
            ),
            onPressed: () {
              // Logic to update note in Firestore
            },
          ),
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: () async {
              // Konfirmasi sebelum menghapus
              bool? confirmDelete = await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Hapus Catatan'),
                  content: Text('Apakah Anda yakin ingin menghapus catatan ini?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: Text('Batal'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: Text('Hapus'),
                    ),
                  ],
                ),
              );

              if (confirmDelete == true) {
                deleteNote(); // Panggil fungsi deleteNote jika dikonfirmasi
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: contentController,
              decoration: InputDecoration(labelText: 'Content'),
              maxLines: 5,
            ),
          ],
        ),
      ),
    );
  }
}
