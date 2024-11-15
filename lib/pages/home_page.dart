import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intermediate_mobile_amcc24/pages/add_note_page.dart';
import 'package:intermediate_mobile_amcc24/pages/detail_note_page.dart';
import 'package:intermediate_mobile_amcc24/shared/themes/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  List<Map<String, dynamic>> notes = [
    {
      'date': '28 May',
      'title': 'Task Management App Ui Design',
      'content':
          'In publishing and graphic design, Lorem ipsum is a placeholder text commonly used.',
      'status': 'Just Now',
      'isTask': false,
    },
    {
      'date': '12 May',
      'title': 'Shopping List',
      'content': ['Apple', 'Mango Juice', 'Banana 5 pcs with', 'ButterMilk'],
      'status': '1h ago',
      'isTask': true,
      'completedTasks': ['Apple'],
    }
  ];

  @override
  void initState() {
    super.initState();
    fetchNotes();
  }

  void fetchNotes() async {
    final snapshot = await firestore.collection('notes').get();
    setState(() {
      notes = snapshot.docs.map((doc) => doc.data()..['id'] = doc.id).toList();
    });
  }

  void openAddNotePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddNotePage(
          onSave: (String title, String content) {
            addNewNote(title, content);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  void addNewNote(String title, String content) async {
    await firestore.collection('notes').add({
      'date': DateTime.now().toString(),
      'title': title,
      'content': content,
      'status': 'Just Now',
      // 'isTask': false,
    });
    fetchNotes();
  }

  void openNotePage(BuildContext context, Map<String, dynamic> note) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailNotePage(note: note, onUpdate: fetchNotes),
      ),
    );
  }

  void logout() async {
    await auth.signOut();
    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text(
          'Notes App',
          style: TextStyle(
            color: whiteColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.filter_list,
              color: whiteColor,
            ),
            onPressed: logout,
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search Here',
                  prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => openNotePage(context, notes[index]),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 2,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                notes[index]['date'],
                                style: const TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                notes[index]['title'],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              if (notes[index]['isTask'])
                                ...notes[index]['content'].map<Widget>((task) {
                                  bool isCompleted = notes[index]
                                          ['completedTasks']
                                      .contains(task);
                                  return Row(
                                    children: [
                                      Checkbox(
                                          value: isCompleted,
                                          onChanged: (val) {}),
                                      Text(task),
                                    ],
                                  );
                                }).toList()
                              else
                                Text(
                                  notes[index]['content'],
                                  style: const TextStyle(color: Colors.black54),
                                ),
                              const SizedBox(height: 5),
                              Text(
                                notes[index]['status'],
                                style: const TextStyle(color: Colors.green),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => openAddNotePage(context),
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add,
          color: whiteColor,
        ),
      ),
    );
  }
}
