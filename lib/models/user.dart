class User {
  int? id;
  String? name;
  String? username;
  String? password;

  User({this.id, this.name, this.username, this.password});
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'username': username,
      'password': password,
    };
  }
}
