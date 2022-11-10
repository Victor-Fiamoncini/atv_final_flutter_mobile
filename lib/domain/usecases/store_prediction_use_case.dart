class AddressParams {
  final String street;
  final String neighborhood;
  final String city;
  final String state;
  final String postalCode;
  final String country;

  const AddressParams({
    required this.street,
    required this.neighborhood,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
  });

  Map toMap() {
    return {
      'street': street,
      'neighborhood': neighborhood,
      'city': city,
      'state': state,
      'postalCode': postalCode,
      'country': country,
    };
  }
}

class WeatherParams {
  final double minTemperature;
  final double maxTemperature;
  final double mainTemperature;
  final double humidity;
  final double clouds;
  final double windSpeed;

  const WeatherParams({
    required this.mainTemperature,
    required this.maxTemperature,
    required this.minTemperature,
    required this.humidity,
    required this.clouds,
    required this.windSpeed,
  });

  Map toMap() {
    return {
      'minTemperature': minTemperature,
      'maxTemperature': maxTemperature,
      'mainTemperature': mainTemperature,
      'humidity': humidity,
      'clouds': clouds,
      'windSpeed': windSpeed,
    };
  }
}

class StorePredictionUseCaseParams {
  final AddressParams address;
  final WeatherParams weather;

  const StorePredictionUseCaseParams({
    required this.address,
    required this.weather,
  });
}

abstract class StorePredictionUseCase {
  Future<void> storePrediction(StorePredictionUseCaseParams params);
}
