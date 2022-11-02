import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> loadDotEnv() async => dotenv.load(fileName: '.env.local');
