import 'package:atv_final_flutter_mobile/data/usecases/remote_fetch_weather_use_case.dart';
import 'package:atv_final_flutter_mobile/domain/usecases/fetch_weather_use_case.dart';
import 'package:atv_final_flutter_mobile/main/factories/http/http_client_factory.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

FetchWeatherUseCase makeFetchWeatherUseCase() {
  final apiKey = dotenv.env['OPEN_WEATHER_MAP_API_KEY'];

  if (apiKey == null) throw Exception('OPEN_WEATHER_MAP_API_KEY not found');

  final httpClient = makeHttpClient();
  final apiEndPoint =
      'https://api.openweathermap.org/data/2.5/weather?appid=$apiKey&units=metric&exclude=minutely';

  return RemoteFetchWeatherUseCase(
    httpClient: httpClient,
    apiEndpoint: apiEndPoint,
  );
}
