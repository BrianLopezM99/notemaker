import 'package:flutter/material.dart';
import 'package:notemaker/screens/home_screen.dart';
import 'package:notemaker/screens/note_editor_screen.dart';
import 'package:notemaker/screens/ai_tools_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const HomeScreen(),
  '/editor': (context) => NoteEditorScreen(),
  '/ai-tools': (context) => const AIToolsScreen(),
};
