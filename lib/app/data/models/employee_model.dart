class Employee {
  late String name;
  late String departement;
  late String createdBy;
  late String image;
  late String createdAt;
  late String documentId;

  Employee.fromMap(Map<String, dynamic> map) {
    name = map['name'];
    departement = map['departement'];
    createdBy = map['createdBy'];
    image = map['image'];
    createdAt = map['createdAt'];
    documentId = map['\$id'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'departement': departement,
      'createdBy': createdBy,
      'image': image,
      'createdAt': createdAt,
      'documentId': documentId,
    };
  }
}
