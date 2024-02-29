class MyUser {
  String? id;
  String? name;
  String? email;

  static const String collectionName = "Users";

  MyUser({
    required this.id,
    required this.name,
    required this.email,
  });

  MyUser.fromJson(Map<String, dynamic>? data)
      : this(
          id: data?["id"] as String,
          name: data?["name"] as String,
          email: data?["email"] as String,
        );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
    };
  }
}
