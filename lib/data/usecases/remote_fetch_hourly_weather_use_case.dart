import 'package:atv_final_flutter_mobile/data/http/http_get_client.dart';
import 'package:atv_final_flutter_mobile/data/mappers/remote_fetch_hourly_weather_mapper.dart';
import 'package:atv_final_flutter_mobile/domain/entities/hourly_weather_entity.dart';
import 'package:atv_final_flutter_mobile/domain/usecases/fetch_hourly_weather_use_case.dart';

class RemoteFetchHourlyWeatherUseCase implements FetchHourlyWeatherUseCase {
  final HttpGetClient httpClient;
  final String apiEndpoint;

  const RemoteFetchHourlyWeatherUseCase({
    required this.httpClient,
    required this.apiEndpoint,
  });

  @override
  Future<List<HourlyWeatherEntity>> fetchHourlyWeather(
    FetchHourlyWeatherUseCaseParams params,
  ) async {
    final mappedUrl = RemoteFetchHourlyWeatherMapper.toApi(apiEndpoint, params);

    final response = await httpClient.get(url: mappedUrl);

    if (response == null) {
      throw Exception('Error to get remote hourly weather data');
    }

    return RemoteFetchHourlyWeatherMapper.toDomain(response);
  }
}
