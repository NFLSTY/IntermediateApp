import 'package:intermediate_mobile_amcc24/models/note_models.dart';

abstract class NoteState {}

class NoteInitial extends NoteState {}

class NoteLoading extends NoteState {}

class NoteLoaded extends NoteState {
  final List<Note> notes;

  NoteLoaded(this.notes);
}

class NoteAdded extends NoteState {}

class NoteUpdated extends NoteState {}

class NoteError extends NoteState {
  final String message;

  NoteError(this.message);
}