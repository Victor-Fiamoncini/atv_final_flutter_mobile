import 'package:atv_final_flutter_mobile/domain/entities/weather_entity.dart';
import 'package:atv_final_flutter_mobile/domain/usecases/fetch_weather_use_case.dart';

class RemoteFetchWeatherMapper {
  static String toApi(String apiEndpoint, FetchWeatherUseCaseParams params) {
    return '$apiEndpoint&lat=${params.latitude}&lon=${params.longitude}';
  }

  static WeatherEntity toDomain(dynamic api) {
    return WeatherEntity(
      minTemperature: double.parse(api['main']['temp_min'].toString()),
      maxTemperature: double.parse(api['main']['temp_max'].toString()),
      mainTemperature: double.parse(api['main']['temp'].toString()),
      humidity: double.parse(api['main']['humidity'].toString()),
      clouds: double.parse(api['clouds']['all'].toString()),
      windSpeed: double.parse(api['wind']['speed'].toString()),
      iconName: api['weather'][0]['icon'],
    );
  }
}
