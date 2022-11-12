import 'package:atv_final_flutter_mobile/domain/entities/hourly_weather_entity.dart';
import 'package:atv_final_flutter_mobile/domain/usecases/fetch_hourly_weather_use_case.dart';

class RemoteFetchHourlyWeatherMapper {
  static String toApi(
    String apiEndpoint,
    FetchHourlyWeatherUseCaseParams params,
  ) {
    return '$apiEndpoint&lat=${params.latitude}&lon=${params.longitude}';
  }

  static List<HourlyWeatherEntity> toDomain(dynamic api) {
    final hourlyWeathers = api['list'] as List;

    return hourlyWeathers.map((hourlyWeather) {
      return HourlyWeatherEntity(
        mainTemperature: double.parse(hourlyWeather['main']['temp'].toString()),
        predictionHour: hourlyWeather['dt'],
        iconName: hourlyWeather['weather'][0]['icon'],
      );
    }).toList();
  }
}
