
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'providers/ormawa_provider.dart';
import 'providers/saved_ormawa_provider.dart';
import 'screens/main_navigation_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');

  final supabaseUrl = dotenv.env['SUPABASE_URL'] ?? '';
  final supabasePublishableKey =
      dotenv.env['SUPABASE_ANON_KEY'] ?? '';

  if (supabaseUrl.isEmpty || supabasePublishableKey.isEmpty) {
    throw Exception(
      'Konfigurasi SUPABASE_URL atau SUPABASE_ANON_KEY belum diisi pada file .env.',
    );
  }

  await Supabase.initialize(
    url: supabaseUrl,
    publishableKey: supabasePublishableKey,
  );

  runApp(const ExploreOrmawaApp());
}

class ExploreOrmawaApp extends StatelessWidget {
  const ExploreOrmawaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => OrmawaProvider()..loadOrmawaCatalog(),
        ),
        ChangeNotifierProvider(
          create: (_) => SavedOrmawaProvider()..loadSavedOrmawa(),
        ),
      ],
      child: MaterialApp(
        title: 'Explore Ormawa Undiksha',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF0D47A1),
            secondary: const Color(0xFFFFB300),
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF0D47A1),
            foregroundColor: Colors.white,
            centerTitle: false,
            elevation: 0,
          ),
        ),
        home: const MainNavigationScreen(),
      ),
    );
  }
}
