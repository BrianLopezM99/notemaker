import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notemaker/models/note_model.dart';
import 'package:notemaker/providers/note_provider.dart';

class NoteEditorScreen extends ConsumerWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final Note? note;

  // Constructor para aceptar una nota opcional (cuando se edita)
  NoteEditorScreen({super.key, this.note});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Si es una nota existente, establecer los valores en los controladores
    if (note != null) {
      titleController.text = note!.title;
      contentController.text = note!.content;
    }

    return Scaffold(
      appBar: AppBar(title: Text(note != null ? 'Editar Nota' : 'Nueva Nota')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(hintText: 'Título'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: contentController,
              maxLines: null,
              decoration: const InputDecoration(hintText: 'Contenido'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                // Crear una nueva nota o actualizar la existente
                if (note != null) {
                  // Actualizar la nota
                  await ref
                      .read(notesProvider.notifier)
                      .updateNote(note!.copyWith(
                        title: titleController.text,
                        content: contentController.text,
                        date: DateTime.now().toIso8601String(),
                      ));
                } else {
                  // Crear una nueva nota
                  await ref.read(notesProvider.notifier).addNote(Note(
                        title: titleController.text,
                        content: contentController.text,
                        date: DateTime.now().toIso8601String(),
                      ));
                }
                // ignore: use_build_context_synchronously
                Navigator.pop(context); // Regresar a la pantalla anterior
              },
              child: Text(note != null ? 'Actualizar' : 'Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
