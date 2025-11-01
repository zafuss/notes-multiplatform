import 'package:flutter_notes/entities/%20note.dart';

abstract class Api {
  Future<List<Note>> loadNotes();
  Future<void> saveNote(String title, String content);
  Future<void> deleteNote(String id);
  Future<void> updateNote(Note note);
  Future<Note?> getNoteById(String id);
}
