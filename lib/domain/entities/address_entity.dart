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
}
