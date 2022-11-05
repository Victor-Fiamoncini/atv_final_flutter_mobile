class AddressEntity {
  final String street;
  final String neighborhood;
  final String city;
  final String state;
  final String postalCode;
  final String country;

  const AddressEntity({
    required this.street,
    required this.neighborhood,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
  });

  factory AddressEntity.fromMap(Map map) {
    final addressEntity = AddressEntity(
      street: map['street'],
      neighborhood: map['neighborhood'],
      city: map['city'],
      state: map['state'],
      postalCode: map['postalCode'],
      country: map['country'],
    );

    return addressEntity;
  }
}
