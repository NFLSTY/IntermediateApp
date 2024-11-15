part of 'note_bloc.dart';

abstract class NoteEvent {}

class AddNoteEvent extends NoteEvent {
  final String title;
  final String content;

  AddNoteEvent({required this.title, required this.content});
}

class UpdateNoteEvent extends NoteEvent {
  final Note note;

  UpdateNoteEvent(this.note);
}

class FetchNotesEvent extends NoteEvent {}