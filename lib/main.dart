import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notemaker/routes/routes.dart';
import 'providers/theme_provider.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeAsync = ref.watch(themeNotifierProvider);

    return themeAsync.when(
      loading: () => const MaterialApp(
        home: Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      ),
      error: (err, stack) => MaterialApp(
        home: Scaffold(
          body: Center(child: Text('Error: $err')),
        ),
      ),
      data: (isDarkMode) {
        final useDarkMode = isDarkMode;
        return Builder(
          builder: (context) {
            try {
              return MaterialApp(
                // ... your MaterialApp configuration
                title: 'Notas con IA',
                themeMode: useDarkMode ? ThemeMode.dark : ThemeMode.light,
                theme: ThemeData.light(),
                darkTheme: ThemeData.dark(),
                initialRoute: '/', // Ruta inicial (debe existir en appRoutes)
                routes: appRoutes,
              );
            } catch (e, stack) {
              debugPrint('Error building MaterialApp: $e');
              debugPrint(stack.toString());
              return MaterialApp(
                home: Scaffold(
                  body: Center(child: Text('Error building app: $e')),
                ),
              );
            }
          },
        );
      },
    );
  }
}
