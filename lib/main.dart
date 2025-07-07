import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news/core/services/notification_service.dart';
import 'package:news/features/auth/presentation/screens/signin_screen.dart';
import 'package:news/features/auth/presentation/screens/signup_screen.dart';
import 'package:news/features/auth/presentation/views/splash_screen.dart';
import 'package:news/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await blockScreenshots();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await NotificationService().init();

  runApp(ProviderScope(child: const MainApp()));
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Background push: ${message.messageId}");
}

// Future<void> blockScreenshots() async {
//   await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
// }

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "News",
      initialRoute: "/",
      routes: {
        "/": (context) => const SplashScreen(),
        "/login": (context) => const SigninScreen(),
        "/register": (context) => const SignupScreen(),
      },
    );
  }
}
