import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intermediate_mobile_amcc24/bloc/note/note_state.dart';
import 'package:intermediate_mobile_amcc24/models/note_models.dart';

part 'note_event.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  NoteBloc() : super(NoteInitial()) {
    on<AddNoteEvent>((event, emit) async {
      try {
        emit(NoteLoading());
        await _firestore.collection('notes').add({
          'title': event.title,
          'content': event.content,
          'date': DateTime.now().toString(),
          'status': 'Just Now',
        });
        emit(NoteAdded());
      } catch (e) {
        emit(NoteError("Failed to add note"));
      }
    });

    on<UpdateNoteEvent>((event, emit) async {
      try {
        emit(NoteLoading());
        await _firestore.collection('notes').doc(event.note.id).update(event.note.ToFirestore());
        emit(NoteUpdated());
      } catch (e) {
        emit(NoteError("Failed to update note"));
      }
    });

    on<FetchNotesEvent>((event, emit) async {
      try {
        emit(NoteLoading());
        var querySnapshot = await _firestore.collection('notes').get();
        List<Note> notes = querySnapshot.docs.map((doc) {
          return Note.fromFirestore(doc.data(), doc.id);
        }).toList();
        emit(NoteLoaded(notes));
      } catch (e) {
        emit(NoteError("Failed to fetch notes"));
      }
    });
  }
}