import 'package:atv_final_flutter_mobile/data/http/http_client.dart';
import 'package:atv_final_flutter_mobile/data/mappers/remote_fetch_weather_mapper.dart';
import 'package:atv_final_flutter_mobile/domain/entities/weather_entity.dart';
import 'package:atv_final_flutter_mobile/domain/usecases/fetch_weather_use_case.dart';

class RemoteFetchWeatherUseCase implements FetchWeatherUseCase {
  final HttpClient httpClient;
  final String apiEndpoint;

  const RemoteFetchWeatherUseCase({
    required this.httpClient,
    required this.apiEndpoint,
  });

  @override
  Future<WeatherEntity> fetchWeather(FetchWeatherUseCaseParams params) async {
    final mappedUrl = RemoteFetchWeatherMapper.toApi(apiEndpoint, params);

    final response = await httpClient.request(method: 'get', url: mappedUrl);

    if (response == null) throw Exception('Error to get remote weather data');

    return RemoteFetchWeatherMapper.toDomain(response);
  }
}
