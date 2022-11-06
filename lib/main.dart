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
    final primaryColor = Colors.redAccent.shade100;
    const tertiaryColor = Color.fromARGB(255, 19, 161, 149);
    const whiteColor = Colors.white;
    const blackColor = Colors.black;
    const errorColor = Colors.red;
    const backgroundColor = Colors.white;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: primaryColor,
        systemNavigationBarColor: primaryColor,
      ),
    );

    return MaterialApp(
      title: 'Weather Prediction',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme(
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
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
            ),
            elevation: MaterialStateProperty.all(0),
            backgroundColor: MaterialStateProperty.all(primaryColor),
            padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: whiteColor,
          ),
          filled: true,
          fillColor: primaryColor,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: const BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          errorStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: errorColor,
          actionTextColor: whiteColor,
        ),
      ),
      home: makeHomePage(),
    );
  }
}
