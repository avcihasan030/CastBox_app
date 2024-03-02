class User {
  final String name;
  final String email;
  final String? country;
  final int? age;
  final String? gender;
  final String? imageUrl;

  User(this.country, this.age, this.gender, this.imageUrl,
      {required this.name, required this.email});
}
