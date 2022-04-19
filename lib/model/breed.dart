class Breed {
  final int? id;
  final String name;
  final String description;

  Breed({
    this.id,
    required this.name,
    required this.description,
  });

  //convert into a map
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "description": description,
    };
  }

  factory Breed.fromMap(Map<String, dynamic> map) {
    return Breed(
        id: map['id']?.toInt() ?? 0,
        name: map['name'] ?? "",
        description: map['description'] ?? "");
  }

  // Implement toString to make it easier to see information about
  // each breed when using the print statement.

  @override
  String toString() => 'Breed(id: $id, name: $name, description: $description)';
}
