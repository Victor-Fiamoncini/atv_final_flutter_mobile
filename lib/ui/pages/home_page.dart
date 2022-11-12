import 'package:atv_final_flutter_mobile/domain/entities/address_entity.dart';
import 'package:atv_final_flutter_mobile/domain/entities/hourly_weather_entity.dart';
import 'package:atv_final_flutter_mobile/domain/entities/weather_entity.dart';
import 'package:atv_final_flutter_mobile/domain/usecases/fetch_address_use_case.dart';
import 'package:atv_final_flutter_mobile/domain/usecases/fetch_hourly_weather_use_case.dart';
import 'package:atv_final_flutter_mobile/domain/usecases/fetch_location_use_case.dart';
import 'package:atv_final_flutter_mobile/domain/usecases/fetch_weather_use_case.dart';
import 'package:atv_final_flutter_mobile/domain/usecases/store_prediction_use_case.dart';
import 'package:atv_final_flutter_mobile/ui/mappers/weather_icon_mapper.dart';
import 'package:atv_final_flutter_mobile/ui/widgets/background_wrapper.dart';
import 'package:atv_final_flutter_mobile/ui/widgets/hourly_weather_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  final FetchLocationUseCase fetchLocationUseCase;
  final FetchAddressUseCase fetchAddressUseCase;
  final FetchWeatherUseCase fetchWeatherUseCase;
  final FetchHourlyWeatherUseCase fetchHourlyWeatherUseCase;
  final StorePredictionUseCase storePredictionUseCase;

  const HomePage({
    required this.fetchLocationUseCase,
    required this.fetchAddressUseCase,
    required this.fetchWeatherUseCase,
    required this.fetchHourlyWeatherUseCase,
    required this.storePredictionUseCase,
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> _storeAddressAndWeatherData(
    AddressEntity address,
    WeatherEntity weather,
  ) async {
    final addressParams = AddressParams(
      street: address.street,
      neighborhood: address.neighborhood,
      city: address.city,
      state: address.state,
      postalCode: address.postalCode,
      country: address.country,
    );

    final weatherParams = WeatherParams(
      mainTemperature: weather.mainTemperature,
      maxTemperature: weather.maxTemperature,
      minTemperature: weather.minTemperature,
      feelsLike: weather.feelsLike,
      humidity: weather.humidity,
      clouds: weather.clouds,
      windSpeed: weather.windSpeed,
    );

    await widget.storePredictionUseCase.storePrediction(
      StorePredictionUseCaseParams(
        address: addressParams,
        weather: weatherParams,
      ),
    );
  }

  Future<Map> _getUserAddressAndWeather() async {
    final position = await widget.fetchLocationUseCase.fetchLocation();

    final futures = await Future.wait([
      widget.fetchAddressUseCase.fetchAddress(
        FetchAddressUseCaseParams(
          latitude: position.latitude,
          longitude: position.longitude,
        ),
      ),
      widget.fetchWeatherUseCase.fetchWeather(
        FetchWeatherUseCaseParams(
          latitude: position.latitude,
          longitude: position.longitude,
        ),
      ),
      widget.fetchHourlyWeatherUseCase.fetchHourlyWeather(
        FetchHourlyWeatherUseCaseParams(
          latitude: position.latitude,
          longitude: position.longitude,
        ),
      ),
    ]);

    final address = futures[0] as AddressEntity;
    final weather = futures[1] as WeatherEntity;
    final hourlyWeather = futures[2] as List<HourlyWeatherEntity>;

    return {
      'address': address,
      'weather': weather,
      'hourlyWeather': hourlyWeather,
    };
  }

  Widget _buildErrorMessage(ThemeData theme) {
    return Center(
      child: Text(
        'Houve um erro ao buscar as informações, tente novamente em breve',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _buildWeatherData(ThemeData theme, AsyncSnapshot snapshot) {
    final address = snapshot.data['address'] as AddressEntity;
    final weather = snapshot.data['weather'] as WeatherEntity;
    final hourlyWeather =
        snapshot.data['hourlyWeather'] as List<HourlyWeatherEntity>;

    _storeAddressAndWeatherData(address, weather);

    final date = DateFormat('dd/MM/yyyy').format(DateTime.now());

    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              address.city,
              style: TextStyle(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            Text(
              date,
              style: TextStyle(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ],
        ),
        const SizedBox(height: 22),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: weatherIconMapper(weather.iconName),
              fit: BoxFit.cover,
            )
          ],
        ),
        const SizedBox(height: 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${weather.mainTemperature.toInt()}°C',
              style: TextStyle(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w600,
                fontSize: 48,
              ),
            )
          ],
        ),
        const SizedBox(height: 22),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mínima: ${weather.minTemperature.toInt()}°C',
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Máxima: ${weather.maxTemperature.toInt()}°C',
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Sensação: ${weather.feelsLike.toInt()}°C',
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Humidade: ${weather.humidity.toInt()}%',
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Nuvens: ${weather.clouds.toInt()}%',
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Vento: ${(weather.windSpeed * 3.6).toStringAsFixed(2)} km/h',
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ],
            )
          ],
        ),
        const SizedBox(height: 22),
        HourlyWeatherList(hourlyWeatherItems: hourlyWeather),
      ],
    );
  }

  Widget _buildLoading(ThemeData theme) {
    return SpinKitThreeBounce(
      color: theme.colorScheme.primary,
      size: 76,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: BackgroundWrapper(
          child: Center(
            child: Container(
              width: mediaQuery.size.width,
              constraints: BoxConstraints(
                minHeight: 440,
                maxHeight: 460,
                minWidth: mediaQuery.size.width,
              ),
              child: Card(
                elevation: 50,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: theme.colorScheme.tertiary,
                  ),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  child: FutureBuilder(
                    future: _getUserAddressAndWeather(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return _buildErrorMessage(theme);
                      }

                      if (snapshot.hasData) {
                        return _buildWeatherData(theme, snapshot);
                      }

                      return _buildLoading(theme);
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
