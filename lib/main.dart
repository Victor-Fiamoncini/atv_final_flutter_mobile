import 'package:atv_final_flutter_mobile/main/config/dotenv.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  await loadDotEnv();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Container(),
    );
  }
}
