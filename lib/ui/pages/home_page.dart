import 'package:atv_final_flutter_mobile/domain/entities/address_entity.dart';
import 'package:atv_final_flutter_mobile/domain/entities/weather_entity.dart';
import 'package:atv_final_flutter_mobile/domain/usecases/fetch_address_use_case.dart';
import 'package:atv_final_flutter_mobile/domain/usecases/fetch_location_use_case.dart';
import 'package:atv_final_flutter_mobile/domain/usecases/fetch_weather_use_case.dart';
import 'package:atv_final_flutter_mobile/domain/usecases/store_prediction_use_case.dart';
import 'package:atv_final_flutter_mobile/ui/mappers/weather_icon_mapper.dart';
import 'package:atv_final_flutter_mobile/ui/widgets/background_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  final FetchLocationUseCase fetchLocationUseCase;
  final FetchAddressUseCase fetchAddressUseCase;
  final FetchWeatherUseCase fetchWeatherUseCase;
  final StorePredictionUseCase storePredictionUseCase;

  const HomePage({
    required this.fetchLocationUseCase,
    required this.fetchAddressUseCase,
    required this.fetchWeatherUseCase,
    required this.storePredictionUseCase,
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<Map> _getUserAddressAndWeather() async {
    final position = await widget.fetchLocationUseCase.fetchLocation();
    final address = await widget.fetchAddressUseCase.fetchAddress(
      FetchAddressUseCaseParams(
        latitude: position.latitude,
        longitude: position.longitude,
      ),
    );
    final weather = await widget.fetchWeatherUseCase.fetchWeather(
      FetchWeatherUseCaseParams(
        latitude: position.latitude,
        longitude: position.longitude,
      ),
    );
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

    return {'address': address, 'weather': weather};
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

    final now = DateTime.now();
    final date = DateFormat('dd/MM/yyyy').format(now);

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
        const SizedBox(height: 20),
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
        )
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
                maxHeight: 400,
                minHeight: 380,
                minWidth: mediaQuery.size.width,
              ),
              child: Card(
                elevation: 50,
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
