import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider para manejar el término de búsqueda
final searchQueryProvider = StateProvider<String>((ref) => '');
