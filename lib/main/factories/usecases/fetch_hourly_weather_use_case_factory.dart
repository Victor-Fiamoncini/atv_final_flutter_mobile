import 'package:atv_final_flutter_mobile/data/usecases/remote_fetch_hourly_weather_use_case.dart';
import 'package:atv_final_flutter_mobile/domain/usecases/fetch_hourly_weather_use_case.dart';
import 'package:atv_final_flutter_mobile/main/factories/http/http_client_factory.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

FetchHourlyWeatherUseCase makeFetchHourlyWeatherUseCase() {
  final apiKey = dotenv.env['OPEN_WEATHER_MAP_API_KEY'];

  if (apiKey == null) throw Exception('OPEN_WEATHER_MAP_API_KEY not found');

  final httpClient = makeHttpClient();
  final apiEndPoint =
      'https://api.openweathermap.org/data/2.5/forecast?appid=$apiKey&units=metric&exclude=minutely';

  return RemoteFetchHourlyWeatherUseCase(
    httpClient: httpClient,
    apiEndpoint: apiEndPoint,
  );
}
