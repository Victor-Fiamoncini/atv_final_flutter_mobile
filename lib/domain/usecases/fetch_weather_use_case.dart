import 'package:atv_final_flutter_mobile/domain/entities/weather_entity.dart';

class FetchWeatherUseCaseParams {
  final double latitude;
  final double longitude;

  const FetchWeatherUseCaseParams({
    required this.latitude,
    required this.longitude,
  });
}

abstract class FetchWeatherUseCase {
  Future<WeatherEntity> fetchWeather(FetchWeatherUseCaseParams params);
}
