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
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                "assets/images/logo-necomic.png",
                width: 200,
                height: 200,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Welcome to necomic",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
