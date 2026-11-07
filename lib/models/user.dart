class Address {
  final String street;
  final String suite;
  final String city;
  final String zipcode;

  const Address({required this.street, required this.suite, required this.city, required this.zipcode});

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    street: json['street'] as String,
    suite: json['suite'] as String,
    city: json['city'] as String,
    zipcode: json['zipcode'] as String,
  );

  String get fullAddress => '$street, $suite, $city, $zipcode';
}

class Company {
  final String name;
  final String catchPhrase;

  const Company({required this.name, required this.catchPhrase});

  factory Company.fromJson(Map<String, dynamic> json) => Company(
    name: json['name'] as String,
    catchPhrase: json['catchPhrase'] as String,
  );
}

class User {
  final int id;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String website;
  final Address address;
  final Company company;

  const User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.website,
    required this.address,
    required this.company,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'] as int,
    name: json['name'] as String,
    username: json['username'] as String,
    email: json['email'] as String,
    phone: json['phone'] as String,
    website: json['website'] as String,
    address: Address.fromJson(json['address'] as Map<String, dynamic>),
    company: Company.fromJson(json['company'] as Map<String, dynamic>),
  );
}
