import 'package:atv_final_flutter_mobile/main/factories/pages/home_page_factory.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env.local');

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color.fromARGB(255, 255, 138, 128);
    const tertiaryColor = Color.fromARGB(255, 19, 161, 149);
    const whiteColor = Colors.white;
    const blackColor = Colors.black;
    const errorColor = Colors.red;
    const backgroundColor = Colors.white;

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: primaryColor,
        systemNavigationBarColor: primaryColor,
      ),
    );

    return MaterialApp(
      title: 'Weather Prediction',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: primaryColor,
          onPrimary: primaryColor,
          secondary: whiteColor,
          onSecondary: whiteColor,
          tertiary: tertiaryColor,
          onTertiary: tertiaryColor,
          error: errorColor,
          onError: errorColor,
          background: backgroundColor,
          onBackground: backgroundColor,
          surface: whiteColor,
          onSurface: whiteColor,
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: whiteColor,
          selectionColor: primaryColor.withOpacity(0.9),
          selectionHandleColor: blackColor,
        ),
      ),
      home: makeHomePage(),
    );
  }
}
