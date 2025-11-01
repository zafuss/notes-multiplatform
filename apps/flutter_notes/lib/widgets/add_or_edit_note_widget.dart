import 'package:flutter/material.dart';
import 'package:flutter_notes/di/injector.dart';
import 'package:flutter_notes/entities/%20note.dart';
import 'package:flutter_notes/utils/api.dart';

class AddOrEditNoteWidget extends StatelessWidget {
  final VoidCallback? onNoteSaved;
  final Note? noteToEdit;

  const AddOrEditNoteWidget({super.key, this.onNoteSaved, this.noteToEdit});

  Future<void> _handleAddNote(String title, String content) async {
    final api = getIt<Api>();
    await api.saveNote(title, content);
  }

  Future<void> _handleEditNote(String title, String content) async {
    final api = getIt<Api>();

    Note newNote = noteToEdit!.copyWith(title: title, content: content);
    await api.updateNote(newNote);
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final titleController = TextEditingController();
    final contentController = TextEditingController();

    if (noteToEdit != null) {
      titleController.text = noteToEdit!.title;
      contentController.text = noteToEdit!.content;
    }

    return Container(
      padding: EdgeInsets.all(16),
      width: double.infinity,
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(labelText: "Title"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please provide title";
                }
                return null;
              },
            ),
            TextFormField(
              controller: contentController,
              decoration: InputDecoration(labelText: "Content"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please provide content";
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            Align(
              alignment: AlignmentGeometry.centerRight,
              child: FilledButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    try {
                      if (noteToEdit == null) {
                        await _handleAddNote(
                          titleController.text,
                          contentController.text,
                        );
                      } else {
                        await _handleEditNote(
                          titleController.text,
                          contentController.text,
                        );
                      }

                      if (context.mounted) {
                        Navigator.pop(context);

                        onNoteSaved?.call();
                      }
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text('Error: $e')));
                      }
                    }
                  }
                },
                child: Text(noteToEdit != null ? "Edit" : "Add"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
