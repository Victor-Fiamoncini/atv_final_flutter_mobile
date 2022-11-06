class WeatherEntity {
  final double minTemperature;
  final double maxTemperature;
  final double mainTemperature;
  final double humidity;
  final double clouds;
  final double windSpeed;

  const WeatherEntity({
    required this.mainTemperature,
    required this.maxTemperature,
    required this.minTemperature,
    required this.humidity,
    required this.clouds,
    required this.windSpeed,
  });

  factory WeatherEntity.fromMap(Map map) {
    final weatherEntity = WeatherEntity(
      minTemperature: map['minTemperature'],
      maxTemperature: map['maxTemperature'],
      mainTemperature: map['mainTemperature'],
      humidity: map['humidity'],
      clouds: map['clouds'],
      windSpeed: map['windSpeed'],
    );

    return weatherEntity;
  }
}
