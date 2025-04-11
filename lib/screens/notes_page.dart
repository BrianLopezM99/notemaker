import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/note_provider.dart';
import '../providers/note_search_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/note_card.dart';

class NotesPage extends ConsumerWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchQuery = ref.watch(searchQueryProvider);
    final isDarkMode = ref.watch(darkModeProvider);
    final notes = ref.watch(notesProvider);

    final filteredNotes = notes.where((note) {
      return note.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
          note.content.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notas'),
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              ref.read(darkModeProvider.notifier).state = !isDarkMode;
              ref.read(themeNotifierProvider.notifier).toggleTheme();
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (query) {
                ref.read(searchQueryProvider.notifier).state = query;
              },
              decoration: InputDecoration(
                hintText: 'Buscar notas...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                suffixIcon: const Icon(Icons.search),
              ),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: filteredNotes.length,
        itemBuilder: (_, index) {
          final note = filteredNotes[index];
          return NoteCard(
            note: note,
            onTap: () {
              Navigator.pushNamed(
                context,
                '/editor',
                arguments: note,
              );
            },
          );
        },
      ),
    );
  }
}
