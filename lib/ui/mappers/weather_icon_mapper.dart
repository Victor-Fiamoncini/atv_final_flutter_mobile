import 'package:flutter/material.dart';

const weatherIcons = {
  '01d': AssetImage('assets/01d.png'),
  '01n': AssetImage('assets/01n.png'),
  '02d': AssetImage('assets/02d.png'),
  '02n': AssetImage('assets/02n.png'),
  '03d': AssetImage('assets/03d.png'),
  '03n': AssetImage('assets/03n.png'),
  '04d': AssetImage('assets/04d.png'),
  '04n': AssetImage('assets/04n.png'),
  '09d': AssetImage('assets/09d.png'),
  '09n': AssetImage('assets/09n.png'),
  '10d': AssetImage('assets/10d.png'),
  '10n': AssetImage('assets/10n.png'),
  '11d': AssetImage('assets/11d.png'),
  '11n': AssetImage('assets/11n.png'),
  '13d': AssetImage('assets/13d.png'),
  '13n': AssetImage('assets/13n.png'),
  '50d': AssetImage('assets/50d.png'),
  '50n': AssetImage('assets/50n.png'),
};

AssetImage weatherIconMapper(String iconCode) {
  return weatherIcons[iconCode] ?? const AssetImage('fallback.png');
}
