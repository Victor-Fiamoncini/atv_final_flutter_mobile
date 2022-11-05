class PositionEntity {
  final double latitude;
  final double longitude;

  const PositionEntity({required this.latitude, required this.longitude});

  factory PositionEntity.fromMap(Map map) {
    final positionEntity = PositionEntity(
      latitude: map['latitude'],
      longitude: map['longitude'],
    );

    return positionEntity;
  }
}
