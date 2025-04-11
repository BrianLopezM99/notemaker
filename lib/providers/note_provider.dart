import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notemaker/services/sqlite_service.dart';

import '../models/note_model.dart';

final notesProvider = StateNotifierProvider<NotesNotifier, List<Note>>((ref) {
  return NotesNotifier();
});

class NotesNotifier extends StateNotifier<List<Note>> {
  NotesNotifier() : super([]) {
    loadNotes();
  }

  Future<void> loadNotes() async {
    state = await NoteDatabase.instance.readAllNotes();
  }

  Future<void> addNote(Note note) async {
    await NoteDatabase.instance.create(note);
    await loadNotes();
  }

  Future<void> deleteNote(int id) async {
    await NoteDatabase.instance.delete(id);
    await loadNotes();
  }

  Future<void> updateNote(Note note) async {
    await NoteDatabase.instance.update(note);
    await loadNotes();
  }
}
