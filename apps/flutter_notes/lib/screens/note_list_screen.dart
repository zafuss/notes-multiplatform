import 'package:flutter/material.dart';
import 'package:flutter_notes/di/injector.dart';
import 'package:flutter_notes/entities/%20note.dart';
import 'package:flutter_notes/utils/api.dart';
import 'package:flutter_notes/widgets/add_or_edit_note_widget.dart';

class NoteListScreen extends StatefulWidget {
  const NoteListScreen({super.key});

  @override
  State<NoteListScreen> createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  late Future<List<Note>> _notesFuture;

  @override
  void initState() {
    super.initState();
    _refreshNotes();
  }

  void _refreshNotes() {
    final Api api = getIt<Api>();
    setState(() {
      _notesFuture = api.loadNotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showModalBottomSheet(
            context: context,
            builder: (context) =>
                AddOrEditNoteWidget(onNoteSaved: _refreshNotes),
          );
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(title: Text("Note list")),
      body: FutureBuilder<List<Note>>(
        future: _notesFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final notes = snapshot.data as List<Note>;
            if (notes.isEmpty) {
              return Center(child: Text("Note list is empty"));
            }
            return ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () async {
                          await showModalBottomSheet(
                            context: context,
                            builder: (context) => AddOrEditNoteWidget(
                              noteToEdit: notes[index],
                              onNoteSaved: _refreshNotes,
                            ),
                          );
                        },
                        icon: Icon(Icons.edit, color: Colors.blue),
                      ),
                      IconButton(
                        onPressed: () async {
                          final api = getIt<Api>();
                          await api.deleteNote(notes[index].id);
                          _refreshNotes();
                        },
                        icon: Icon(Icons.delete, color: Colors.red),
                      ),
                    ],
                  ),
                  title: Text(notes[index].title),
                  subtitle: Text(notes[index].content),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
