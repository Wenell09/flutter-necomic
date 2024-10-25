import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_komik/pages/navigation_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Necomic",
      debugShowCheckedModeBanner: false,
      home: NavigationPage(),
    );
  }
}
