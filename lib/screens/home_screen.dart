import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notemaker/screens/notes_page.dart';
import '../providers/note_provider.dart';
import 'note_editor_screen.dart';
import 'ai_tools_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedIndex = 0;

  // Control de las pantallas según la pestaña
  final List<Widget> _pages = [
    NotesPage(), // Aquí vamos a mostrar las notas
    const AIToolsScreen(), // IA
  ];

  // Cambiar la pestaña seleccionada
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Cambia la vista según la pestaña
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/editor'),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.note),
            label: 'Notas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb),
            label: 'IA',
          ),
        ],
      ),
    );
  }
}
