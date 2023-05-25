class Address2 {
  final String street;
  final String city;
  final String provice;
  final String postalCode;
  final String country;

  // -------------------------
  // Constructors & Factories
  // -------------------------

  Address2({
    required this.street,
    required this.city,
    required this.provice,
    required this.postalCode,
    required this.country,
  });

  factory Address2.fromJson(Map<String, dynamic> json) {
    return Address2(
      street: json['street'] ?? "",
      city: json['city'] ?? "",
      provice: json['provice'] ?? "",
      postalCode: json['postalCode'] ?? "",
      country: json['country'] ?? "",
    );
  }

  Map<String, dynamic> makeReponse() => {
        'street': street,
        'city': city,
        'province': provice,
        'postalCode': postalCode,
        'country': country,
      };
}
