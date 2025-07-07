import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news/features/auth/presentation/screens/signin_screen.dart';
import 'package:news/features/main/screens/main_screen.dart';
import '../providers/auth_provider.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  // Future<void> checkRoot(BuildContext context) async {
  //   final isRooted = await RootCheck.isRooted ?? false;
  //   if (isRooted) {
  //     showDialog(
  //       context: context,
  //       builder: (_) => AlertDialog(
  //         title: const Text("Xavfsizlik ogohlantirishi"),
  //         content: const Text("Rootlangan qurilmada ilova ishlamaydi."),
  //         actions: [
  //           TextButton(
  //             onPressed: () => Future.delayed(
  //               const Duration(milliseconds: 500),
  //               () => exit(0),
  //             ),
  //             child: const Text("Chiqish"),
  //           ),
  //         ],
  //       ),
  //       barrierDismissible: false,
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // checkRoot(context);
    final authState = ref.watch(authStateProvider);

    return authState.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('Error: $e'))),
      data: (user) {
        if (user != null) {
          return const MainScreen(); // placeholder
        } else {
          return const SigninScreen();
        }
      },
    );
  }
}
