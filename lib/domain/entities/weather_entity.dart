class WeatherEntity {
  final double minTemperature;
  final double maxTemperature;
  final double mainTemperature;
  final double humidity;
  final double clouds;
  final double windSpeed;
  final String iconName;

  const WeatherEntity({
    required this.mainTemperature,
    required this.maxTemperature,
    required this.minTemperature,
    required this.humidity,
    required this.clouds,
    required this.windSpeed,
    required this.iconName,
  });
}
