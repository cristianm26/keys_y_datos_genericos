import 'package:flutter/material.dart';
import 'package:generic_types_and_keys/pages/login_page.dart';

/* import 'package:generic_types_and_keys/pages/adaptative_page.dart';
import 'package:generic_types_and_keys/pages/keys_page.dart';
 */
/* import 'pages/home_pages.dart';
 */
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      /*  home: const HomePage(), */
      // home: const KeysPage(),
      home: const LoginPage(),
    );
  }
}
