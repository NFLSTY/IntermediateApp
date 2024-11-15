class Note {
  final String id;
  final String title;
  final String content;
  final String date;
  final String status;
  final bool isTask;
  final List<String>? completedTasks;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.status,
    this.isTask = false,
    this.completedTasks,
  });

  factory Note.fromFirestore(Map<String, dynamic> data, String documentId) {
    return Note(
      id: documentId,
      title: data['title']??'',
      content: data['content']??'',
      date: data['date']??'',
      status: data['status']??'',
      isTask: data['isTask']?? false,
      completedTasks: List<String>.from(data['completedTasks']?? []),
    );
  }

  // ignore: non_constant_identifier_names
  Map<String, dynamic> ToFirestore() {
    return {
      'title': title,
      'content': content,
      'date': date,
      'status': status,
      'isTask': isTask,
      'completedTasks': completedTasks,
    };
  }
}