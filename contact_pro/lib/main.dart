import 'package:contact_pro/pages/barre_navigation.dart';
import 'package:contact_pro/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Conserver le splash screen
  FlutterNativeSplash.preserve(
    widgetsBinding: WidgetsFlutterBinding.ensureInitialized(),
  );
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contacts App',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto',
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // Tant que Firebase vérifie la session
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox.shrink();
        }

        // Fermer le splash natif une seule fois
        FlutterNativeSplash.remove();

        // Utilisateur connecté
        if (snapshot.hasData) {
          return const BarreNavigation();
        }

        // Utilisateur non connecté
        return const LoginPage();
        },
      ),
    );
  }
}
