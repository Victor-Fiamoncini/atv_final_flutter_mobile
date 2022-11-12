import 'package:atv_final_flutter_mobile/domain/entities/hourly_weather_entity.dart';
import 'package:atv_final_flutter_mobile/ui/mappers/weather_icon_mapper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HourlyWeatherList extends StatelessWidget {
  final List<HourlyWeatherEntity> hourlyWeatherItems;

  const HourlyWeatherList({required this.hourlyWeatherItems, super.key});

  String _getFormattedHour(int time) {
    final epoch = DateTime.fromMillisecondsSinceEpoch(time * 1000);

    return DateFormat('HH:mm').format(epoch);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context);

    return Container(
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.symmetric(vertical: 2),
      constraints: BoxConstraints(
        minHeight: 120,
        maxHeight: 120,
        minWidth: mediaQuery.size.width,
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: hourlyWeatherItems.length,
        itemBuilder: ((context, index) {
          final hourlyWeatherItem = hourlyWeatherItems[index];

          return GestureDetector(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: theme.colorScheme.secondary,
                border: Border.all(
                  color: theme.colorScheme.tertiary.withOpacity(0.6),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    _getFormattedHour(hourlyWeatherItem.predictionHour),
                    style: TextStyle(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  Image(
                    image: weatherIconMapper(hourlyWeatherItem.iconName),
                    height: 36,
                    width: 36,
                  ),
                  Text(
                    '${hourlyWeatherItem.mainTemperature.toInt()}°C',
                    style: TextStyle(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
