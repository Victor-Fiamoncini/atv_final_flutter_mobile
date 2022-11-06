import 'package:atv_final_flutter_mobile/domain/usecases/fetch_weather_use_case.dart';

class RemoteFetchWeatherMapper {
  static String toApi(String apiEndpoint, FetchWeatherUseCaseParams params) {
    return '$apiEndpoint&lat=${params.latitude}&lon=${params.longitude}';
  }
}
