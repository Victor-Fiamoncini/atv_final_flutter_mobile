import 'package:atv_final_flutter_mobile/main/factories/usecases/fetch_address_use_case_factory.dart';
import 'package:atv_final_flutter_mobile/main/factories/usecases/fetch_hourly_weather_use_case_factory.dart';
import 'package:atv_final_flutter_mobile/main/factories/usecases/fetch_location_use_case_factory.dart';
import 'package:atv_final_flutter_mobile/main/factories/usecases/fetch_weather_use_case_factory.dart';
import 'package:atv_final_flutter_mobile/main/factories/usecases/store_prediction_use_case_factory.dart';
import 'package:atv_final_flutter_mobile/ui/pages/home_page.dart';
import 'package:flutter/material.dart';

Widget makeHomePage() {
  final fetchLocationUseCase = makeFetchLocationUseCase();
  final fetchAddressUseCase = makeFetchAddressUseCase();
  final fetchWeatherUseCase = makeFetchWeatherUseCase();
  final fetchHourlyWeatherUseCase = makeFetchHourlyWeatherUseCase();
  final storePredictionUseCase = makeStorePredictionUseCase();

  return HomePage(
    fetchLocationUseCase: fetchLocationUseCase,
    fetchAddressUseCase: fetchAddressUseCase,
    fetchWeatherUseCase: fetchWeatherUseCase,
    fetchHourlyWeatherUseCase: fetchHourlyWeatherUseCase,
    storePredictionUseCase: storePredictionUseCase,
  );
}
