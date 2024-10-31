import 'package:flutter/material.dart';
import 'package:flutter_komik/pages/navigation_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
        const Duration(seconds: 1),
        // ignore: use_build_context_synchronously
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const NavigationPage(),
            )));
    return const Scaffold(
      body: Center(
        child: Text(
          "WELCOME TO NECOMIC",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
