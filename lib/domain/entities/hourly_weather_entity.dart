class HourlyWeatherEntity {
  final double mainTemperature;
  final int predictionHour;
  final String iconName;

  const HourlyWeatherEntity({
    required this.mainTemperature,
    required this.predictionHour,
    required this.iconName,
  });
}
