import 'dart:convert';

import 'package:flutter_notes/entities/%20note.dart';
import 'package:flutter_notes/utils/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class ApiStorageImpl extends Api {
  final String key = "notes_key";

  @override
  Future<List<Note>> loadNotes() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? notesData = prefs.getString(key);

      print(notesData);
      if (notesData != null) {
        List<dynamic> decoded = jsonDecode(notesData) as List<dynamic>;
        return decoded
            .map((e) => Note.fromMap(e as Map<String, dynamic>))
            .toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  @override
  Future<void> saveNote(String title, String content) async {
    try {
      print("Saving note: $title");
      List<Note> noteList = await loadNotes();
      SharedPreferences prefs = await SharedPreferences.getInstance();

      noteList.add(
        Note(
          id: Uuid().v4(),
          title: title,
          content: content,
          updatedAt: DateTime.now().millisecondsSinceEpoch,
        ),
      );
      await prefs.setString(
        key,
        jsonEncode(noteList.map((n) => n.toMap()).toList()),
      );
    } catch (e) {
      print("Error saving note: $e");
    }
  }

  @override
  Future<void> updateNote(Note note) async {
    try {
      List<Note> noteList = await loadNotes();
      SharedPreferences prefs = await SharedPreferences.getInstance();

      for (int i = 0; i < noteList.length; i++) {
        if (note.id == noteList[i].id) {
          noteList[i] = noteList[i].copyWith(
            title: note.title,
            content: note.content,
            updatedAt: DateTime.now().millisecondsSinceEpoch,
          );
          break;
        }
      }
      await prefs.setString(
        key,
        jsonEncode(noteList.map((n) => n.toMap()).toList()),
      );
    } catch (e) {
      print("Error updating note: $e");
    }
  }

  @override
  Future<Note?> getNoteById(String id) async {
    List<Note> notes = await loadNotes();
    for (var note in notes) {
      if (note.id == id) {
        return note;
      }
    }
    return null;
  }

  @override
  Future<void> deleteNote(String id) async {
    try {
      List<Note> noteList = await loadNotes();
      SharedPreferences prefs = await SharedPreferences.getInstance();

      noteList.removeWhere((note) => note.id == id);
      await prefs.setString(
        key,
        jsonEncode(noteList.map((n) => n.toMap()).toList()),
      );
    } catch (e) {
      print("Error deleting note: $e");
    }
  }
}
