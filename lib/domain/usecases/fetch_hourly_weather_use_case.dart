import 'package:atv_final_flutter_mobile/domain/entities/hourly_weather_entity.dart';

class FetchHourlyWeatherUseCaseParams {
  final double latitude;
  final double longitude;

  const FetchHourlyWeatherUseCaseParams({
    required this.latitude,
    required this.longitude,
  });
}

abstract class FetchHourlyWeatherUseCase {
  Future<List<HourlyWeatherEntity>> fetchHourlyWeather(
    FetchHourlyWeatherUseCaseParams params,
  );
}
