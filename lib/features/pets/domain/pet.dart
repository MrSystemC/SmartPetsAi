class Pet {
  const Pet({
    required this.id,
    required this.name,
    required this.type,
    required this.breed,
    required this.age,
    required this.weight,
    required this.about,
  });

  final String id;
  final String name;
  final String type;
  final String breed;
  final String age;
  final String weight;
  final String about;

  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      type: json['type'] as String? ?? '',
      breed: json['breed'] as String? ?? '',
      age: json['age'] as String? ?? '',
      weight: json['weight'] as String? ?? '',
      about: json['about'] as String? ?? '',
    );
  }
}
