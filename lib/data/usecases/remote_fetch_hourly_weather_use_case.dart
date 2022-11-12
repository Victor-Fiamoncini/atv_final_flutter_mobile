import 'package:atv_final_flutter_mobile/data/http/http_client.dart';
import 'package:atv_final_flutter_mobile/domain/entities/hourly_weather_entity.dart';
import 'package:atv_final_flutter_mobile/domain/usecases/fetch_hourly_weather_use_case.dart';

class RemoteFetchHourlyWeatherUseCase implements FetchHourlyWeatherUseCase {
  final HttpClient httpClient;
  final String apiEndpoint;

  const RemoteFetchHourlyWeatherUseCase({
    required this.httpClient,
    required this.apiEndpoint,
  });

  @override
  Future<List<HourlyWeatherEntity>> fetchHourlyWeather(
    FetchHourlyWeatherUseCaseParams params,
  ) {
    throw UnimplementedError();
  }
}
